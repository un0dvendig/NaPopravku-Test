//
//  RepositoryWarehouse.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

/// A singleton object that is responsible for storing and managing all Repository entities.
/// NOTE: Could be swapped with some kind of database.
class RepositoryWarehouse {
    
    // MARK: - Properties

    static let shared = RepositoryWarehouse()
    
    // MARK: - Private properties
    
    private let queue = DispatchQueue(label: "un0dvend1g.un0dvend1g.NaPopravku-Test.backgroundQueue", qos: .background, attributes: .concurrent)
    private var repositories: [Repository]
    private var lastRepositoryID: Int?
    private var isFetchInProgress: Bool = false
    
    // MARK: - Initialization
    
    private init() {
        self.repositories = []
    }
    
    // MARK: - Computed properties
    
    dynamic var totalNumberOfRepositories: Int {
        get {
            queue.sync {
                return self.repositories.count
            }
        }
    }
    
    // MARK: - Methods
    
    /// Returns all available Repository entities.
    func getAllRepositories() -> [Repository] {
        var availableRepositories: [Repository] = []
        queue.sync {
            availableRepositories = repositories
        }
        return availableRepositories
    }
    
    /// Returns a Repository entity at given index. If no found, returns nil.
    func getRepository(at index: Int) -> Repository? {
        guard index < repositories.count else {
            return nil
        }
        var repository: Repository? = nil
        queue.sync {
            repository = repositories[index]
        }
        return repository
    }
    
    /// Adds the Repository to the end of the array of available Repository entities.
    func addRepository(_ repository: Repository) {
        queue.async(flags: .barrier) {
            self.repositories.append(repository)
        }
    }
    
    /// Adds the Repositories to the end of the array of available Repository entities.
    func addRepositories(_ repositories: [Repository]) {
        queue.async(flags: .barrier) {
            self.repositories.append(contentsOf: repositories)
        }
    }
    
    /// Replaces a Repository entity at given index with the given Repository.
    /// If the index is out of range, nothing will happen.
    func replaceRepository(at index: Int, with repository: Repository) {
        queue.async(flags: .barrier) {
            guard index < self.repositories.count else {
                return
            }
            self.repositories[index] = repository
        }
    }
    
    /// Deletes Repository entity at given index.
    /// If the index is out of range, nothing will happen.
    func deleteRepository(at index: Int) {
        queue.async(flags: .barrier) {
            guard index < self.repositories.count else {
                return
            }
            self.repositories.remove(at: index)
        }
    }

    /// Deletes all available Person entities.
    func deleteAllRepositories() {
        queue.async(flags: .barrier) {
            self.repositories = []
        }
    }
    
    /// Returns index of the given repository in array of available repositories
    func findRepositoryIndex(_ repository: Repository) -> Int? {
        var index: Int?
        queue.sync {
            index = self.repositories.firstIndex(where: { $0 == repository })
        }
        return index
    }
    
    /// Fetches more repositores from default source with completion.
    /// NOTE: By default fetches 100 entities. Also uses last repository id if there was one.
    func fetchMoreRepositories(completion: @escaping (Result<Void, Error>) -> Void) {
        /// Bail out if there is a fetch in progress.
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        /// Using last ID to build proper URL
        var downloadURL: URL?
        if self.totalNumberOfRepositories > 0 {
            guard let lastRepository = self.getRepository(at: self.totalNumberOfRepositories - 1) else {
                fatalError("Cannot get last repository, but should be able to do so.")
            }
            let lastRepositoryID = lastRepository.id
            let stringID = String(lastRepositoryID)
            guard let url = URLBuilder()
                .set(scheme: "https")
                .set(host: "api.github.com")
                .set(path: "repositories")
                .addQueryItem(name: "since", value: stringID)
                .build() else {
                    fatalError("The building URL is invalid.")
            }
            downloadURL = url
        } else {
            guard let url = URLBuilder()
                .set(scheme: "https")
                .set(host: "api.github.com")
                .set(path: "repositories")
                .build() else {
                    fatalError("The building URL is invalid.")
            }
            downloadURL = url
        }
        
        guard let url = downloadURL else {
            fatalError()
        }
        
        DownloadManager.shared.downloadData(from: url) { (result) in
            switch result {
            case .success(let data):
                guard let repositories: [Repository] = DataWorker.shared.decode(data) else {
                    let error = CustomError.errorWithText("Cannot decode given data into Repository entities: \(data)")
                    self.isFetchInProgress = false
                    completion(.failure(error))
                    return
                }
                self.addRepositories(repositories)
                self.isFetchInProgress = false
                completion(.success(()))
            case .failure(let error):
                self.isFetchInProgress = false
                completion(.failure(error))
            }
        }
    }
    
    /// Fetches more info about the repository with completion.
    func fetchMoreInfo(about repository: Repository, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let index = self.findRepositoryIndex(repository) else {
            fatalError("Given repository \(repository.name) for some reason is not part of available repositories.")
        }
        
        /// Not sure how commits URL is build, so using URL that returns GitHub's API. Ideally should use URLBuilder.
        var commitsURLString = repository.commitsURL
        if commitsURLString.hasSuffix("{/sha}") {
            commitsURLString = commitsURLString.replacingOccurrences(of: "{/sha}", with: "")
        }
        
        guard let commitsURL = URL(string: commitsURLString) else {
            let error = CustomError.errorWithText("The repository \(repository.name) has invalid commits url: \(repository.commitsURL)")
            completion(.failure(error))
            return
        }
        
        DownloadManager.shared.downloadData(from: commitsURL) { (result) in
            switch result {
            case .success(let data):
                guard let commits: [Commit] = DataWorker.shared.decode(data) else {
                    let error = CustomError.errorWithText("Cannot decode given data into Commit entities: \(data)")
                    completion(.failure(error))
                    return
                }
                
                let updatedRepository = repository
                updatedRepository.commits = commits
                self.replaceRepository(at: index, with: updatedRepository)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
