//
//  NaPopravku_Test_Tests.swift
//  NaPopravku Test Tests
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import XCTest
@testable import NaPopravku_Test

class NaPopravku_Test_Tests: XCTestCase {

    // MARK: - Models
    
    func testCommitNodeAuthorModel() {
        let author = CommitNodeAuthor(name: "Joshua", date: "2011-04-14T16:00:49Z")
        XCTAssertNotNil(author)
        XCTAssertEqual(author.name, "Joshua")
        XCTAssertEqual(author.date, "2011-04-14T16:00:49Z")
    }
    
    func testCommitNodeModel() {
        let author = CommitNodeAuthor(name: "Joshua", date: "2011-04-14T16:00:49Z")
        let commitNode = CommitNode(author: author, message: "Test commit")
        XCTAssertNotNil(commitNode)
        XCTAssertEqual(commitNode.message, "Test commit")
        XCTAssertEqual(commitNode.author, author)
    }
    
    func testCommitModel() {
        let emptyCommit = Commit(sha: "djasd89asjd", commit: nil, parents: nil)
        XCTAssertNotNil(emptyCommit)
        XCTAssertNil(emptyCommit.commit)
        XCTAssertNil(emptyCommit.parents)
        XCTAssertEqual(emptyCommit.sha, "djasd89asjd")
        
        let author = CommitNodeAuthor(name: "Joshua", date: "2011-04-14T16:00:49Z")
        let commitNode = CommitNode(author: author, message: "Test commit")
        let commitWithCommitNode = Commit(sha: "7sdha9sdajsd", commit: commitNode, parents: nil)
        XCTAssertNotNil(commitWithCommitNode)
        XCTAssertNil(commitWithCommitNode.parents)
        XCTAssertNotNil(commitWithCommitNode.commit)
        XCTAssertEqual(commitWithCommitNode.commit, commitNode)
        
        let parentCommit = Commit(sha: "uasdh9ajd0asd", commit: nil, parents: nil)
        let commit = Commit(sha: "uaisduasd0", commit: nil, parents: [parentCommit])
        XCTAssertNotNil(commit)
        XCTAssertNil(commit.commit)
        XCTAssertNotNil(commit.parents)
        XCTAssertEqual(commit.parents?.count, 1)
        XCTAssertEqual(commit.parents?.first, parentCommit)
    }
    
    func testOwnerModel() {
        let owner = Owner(login: "the_only_owner", avatarURL: nil)
        XCTAssertNotNil(owner)
        XCTAssertNil(owner.avatarURL)
        XCTAssertEqual(owner.login, "the_only_owner")
        
        let ownerWithAvatarURL = Owner(login: "totallyNotARobot", avatarURL: "http://www.captcha.net/images/recaptcha-example.gif")
        XCTAssertNotNil(ownerWithAvatarURL)
        XCTAssertEqual(ownerWithAvatarURL.login, "totallyNotARobot")
        XCTAssertEqual(ownerWithAvatarURL.avatarURL, "http://www.captcha.net/images/recaptcha-example.gif")
    }
    
    func testRepositoryModel() {
        let owner = Owner(login: "test_repo_owner", avatarURL: nil)
        let repository = Repository(id: 7777, name: "Test repo", owner: owner, commitsURL: "https://example.com", commits: nil)
        XCTAssertNotNil(repository)
        XCTAssertNil(repository.commits)
        XCTAssertEqual(repository.id, 7777)
        XCTAssertEqual(repository.name, "Test repo")
        XCTAssertEqual(repository.owner, owner)
        XCTAssertEqual(repository.commitsURL, "https://example.com")
        
        let commitNodeAuthor = CommitNodeAuthor(name: "Jonnah", date: "2018-04-11T18:12:49Z")
        let commitNode = CommitNode(author: commitNodeAuthor, message: "Initial commit")
        let commit = Commit(sha: "aiusdhsa9udja", commit: commitNode, parents: nil)
        repository.commits = [commit]
        XCTAssertNotNil(repository.commits)
        XCTAssertEqual(repository.commits?.count, 1)
        XCTAssertEqual(repository.commits?.first, commit)
    }
    
    // MARK: - Extensions
    
    
    func testHasSuccessStatusCodeExtension() {
        guard let urlPlaceholder = URL(string: "https://example.com") else {
            XCTFail()
            return
        }
        
        guard var httpResponse = HTTPURLResponse(url: urlPlaceholder, statusCode: 1, httpVersion: nil, headerFields: nil) else {
            XCTFail()
            return
        }
        XCTAssertNotNil(httpResponse)
        XCTAssertFalse(httpResponse.hasSuccessStatusCode)
        
        guard let newHttpResponse = HTTPURLResponse(url: urlPlaceholder, statusCode: 100, httpVersion: nil, headerFields: nil) else {
            XCTFail()
            return
        }
        httpResponse = newHttpResponse
        XCTAssertNotNil(httpResponse)
        XCTAssertFalse(httpResponse.hasSuccessStatusCode)
        
        guard let anotherHttpResponse = HTTPURLResponse(url: urlPlaceholder, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail()
            return
        }
        httpResponse = anotherHttpResponse
        XCTAssertNotNil(httpResponse)
        XCTAssertTrue(httpResponse.hasSuccessStatusCode)
    }
    
    func testPercentEncodedExtension() {
        let firstParametersStringToCompareWith = "parameter1=123"
        let firstParameters: [String: Any] = [
            "parameter1": 123
        ]
        XCTAssertNotNil(firstParameters.percentEncoded())
        
        guard let firstParametersData = firstParameters.percentEncoded(),
            let firstTestString = String(data: firstParametersData, encoding: .utf8) else {
            XCTFail()
            return
        }
        XCTAssertEqual(firstTestString, firstParametersStringToCompareWith)
        
        // -- //
        
        let secondParametersStringToCompareWith = "parameter2=test%20value"
        let secondParameters: [String: Any] = [
            "parameter2": "test value"
        ]
        XCTAssertNotNil(secondParameters.percentEncoded())
        
        guard let secondParametersData = secondParameters.percentEncoded(),
            let secondTestString = String(data: secondParametersData, encoding: .utf8) else {
            XCTFail()
            return
        }
        XCTAssertEqual(secondTestString, secondParametersStringToCompareWith)
        
        // -- //
        
        let thirdParametersStringToCompareWith = "parameter3=another%23value"
        let thirdParameters: [String: Any] = [
            "parameter3": "another#value"
        ]
        XCTAssertNotNil(thirdParameters.percentEncoded())
        
        guard let thirdParametersData = thirdParameters.percentEncoded(),
            let thirdTestString = String(data: thirdParametersData, encoding: .utf8) else {
            XCTFail()
            return
        }
        XCTAssertEqual(thirdTestString, thirdParametersStringToCompareWith)
        
        // -- //
        
        let fourthParametersStringToCompareWith = "parameter4=new%2Fvalue"
        let fourthParameters: [String: Any] = [
            "parameter4": "new/value"
        ]
        XCTAssertNotNil(fourthParameters.percentEncoded())
        
        guard let fourthParametersData = fourthParameters.percentEncoded(),
            let fourthTestString = String(data: fourthParametersData, encoding: .utf8) else {
            XCTFail()
            return
        }
        XCTAssertEqual(fourthTestString, fourthParametersStringToCompareWith)
    }
    
    // MARK: - Utils
    
    func testDownloadManager() {
        var realDataToTest: Data? // Real avatar image data that should be downloaded
        let realDataExpectation = expectation(description: "Checking that image data is downloaded")
        /// URL example from: https://jsonplaceholder.typicode.com
        guard let realImageURL = URL(string: "https://via.placeholder.com/600/92c950") else {
            XCTFail()
            return
        }
        
        var anotherRealDataToTest: Data? // Another avatar image data that should be downloaded
        let anotherRealDataExpectation = expectation(description: "Checking that another image data is downloaded")
        guard let anotherRealImageURL = URL(string: "https://via.placeholder.com/800/af29z0") else {
            XCTFail()
            return
        }
        
        var noDataToTest: Data? // Data that should not be downloaded
        let noDataExpectation = expectation(description: "Checking that data is not downloaded")
        guard let wrongImageURL = URL(string: "https://viaaa.placeh0lder.com/600/92c950/1?yes=no") else {
            XCTFail()
            return
        }
        
        let downloadManager = DownloadManager.shared
        downloadManager.downloadData(from: realImageURL) { (result) in
            switch result {
            case .success(let data):
                realDataToTest = data
                realDataExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        downloadManager.downloadData(from: anotherRealImageURL) { (result) in
            switch result {
            case .success(let data):
                anotherRealDataToTest = data
                anotherRealDataExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        downloadManager.downloadData(from: wrongImageURL) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                noDataToTest = nil
                noDataExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertNotNil(realDataToTest)
            XCTAssertNotNil(anotherRealDataToTest)
            XCTAssertNil(noDataToTest)
            XCTAssertNotEqual(realDataToTest, anotherRealDataToTest)
        }
    }
    
    func testDataWorkerImageConvertion() {
        var testImage: UIImage?
        let testExpectation = expectation(description: "Checking that downloaded data is properly converted to UIImage")
        /// URL example from: https://jsonplaceholder.typicode.com
        guard let testImageURL = URL(string: "https://via.placeholder.com/600/92c950") else {
            XCTFail()
            return
        }
        
        DownloadManager.shared.downloadData(from: testImageURL) { (result) in
            switch result {
            case .success(let data):
                if let image = DataWorker.shared.convertDataToUIImage(data) {
                    testImage = image
                    testExpectation.fulfill()
                } else {
                    let error = CustomError.cannotCreateUIImage
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 2) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertNotNil(testImage)
        }
    }
    
    func testImageCache() {
        let imageCache = ImageCache.shared
        
        var firstTestImage: UIImage?
        let firstTestExpectation = expectation(description: "Checking that downloaded image is properly loaded from cache")
        /// URL example from: https://jsonplaceholder.typicode.com
        guard let firstTestImageURL = URL(string: "https://via.placeholder.com/600/92c950") else {
            XCTFail()
            return
        }
        DownloadManager.shared.downloadData(from: firstTestImageURL) { (result) in
            switch result {
            case .success(let data):
                if let image = DataWorker.shared.convertDataToUIImage(data) {
                    imageCache.save(image, forKey: firstTestImageURL.absoluteString)
                    
                    if let firstImageFromCache = imageCache.getImage(forKey: firstTestImageURL.absoluteString) {
                        firstTestImage = firstImageFromCache
                        firstTestExpectation.fulfill()
                    }
                } else {
                    let error = CustomError.cannotCreateUIImage
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        var secondTestImage: UIImage?
        let secondTestExpectation = expectation(description: "Checking that downloaded image is properly loaded from cache")
        guard let secondTestImageURL = URL(string: "https://via.placeholder.com/900/af29z0") else {
            XCTFail()
            return
        }
        DownloadManager.shared.downloadData(from: secondTestImageURL) { (result) in
            switch result {
            case .success(let data):
                if let image = DataWorker.shared.convertDataToUIImage(data) {
                    imageCache.save(image, forKey: secondTestImageURL.absoluteString)
                    
                    if let secondImageFromCache = imageCache.getImage(forKey: secondTestImageURL.absoluteString) {
                        secondTestImage = secondImageFromCache
                        secondTestExpectation.fulfill()
                    }
                } else {
                    let error = CustomError.cannotCreateUIImage
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 2) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertNotNil(firstTestImage)
            XCTAssertNotNil(secondTestImage)
            
            XCTAssertNotEqual(firstTestImage, secondTestImage)
        }
    }
    
    func testURLBuilder() {
        guard let properURLToCompareWith = URL(string: "https://napopravku.ru") else {
            XCTFail()
            return
        }
        guard let urlToTest = URLBuilder()
            .set(scheme: "https")
            .set(host: "napopravku.ru")
            .build() else {
                XCTFail()
                return
        }
        XCTAssertEqual(urlToTest, properURLToCompareWith)
        
        /// URL example from: https://jsonplaceholder.typicode.com
        guard let anotherProperURLToCompareWith = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=1") else {
            XCTFail()
            return
        }
        guard let anotherUrlToTest = URLBuilder()
            .set(scheme: "https")
            .set(host: "jsonplaceholder.typicode.com")
            .set(path: "posts")
            .addQueryItem(name: "userId", value: "1")
            .build() else {
                XCTFail()
                return
        }
        XCTAssertEqual(anotherUrlToTest, anotherProperURLToCompareWith)
    }
    
    // MARK: - View models
    
    func testRepositoryListTableViewCellViewModel() {
        let owner = Owner(login: "000x0x0", avatarURL: "https://via.placeholder.com/600/92c950")
        let repository = Repository(id: 3012321, name: "Some kind of repository", owner: owner, commitsURL: "https://www.example.com", commits: nil)
        
        let viewModel = RepositoryListTableViewCellViewModel(repository: repository)
        XCTAssertEqual(viewModel.repositoryName, repository.name)
        guard let stringAvatarURL = owner.avatarURL,
            let avatarURL = URL(string: stringAvatarURL) else {
                XCTFail()
                return
        }
        XCTAssertEqual(viewModel.ownerAvatarURL, avatarURL)
        XCTAssertEqual(viewModel.ownerLogin, owner.login)
    }
    
    func testRepositoryListViewModel() {
        let viewModel = RepositoryListViewModel()
        XCTAssertNotNil(viewModel.tableViewDataSource)
        XCTAssertNotNil(viewModel.tableViewDataSourcePrefetching)
        XCTAssertNotNil(viewModel.tableViewDelegate)
    }
    
    func testRepositoryInfoViewModel() {
        let owner = Owner(login: "mojombo", avatarURL: "https://avatars0.githubusercontent.com/u/1?v=4")
        let repository = Repository(id: 1, name: "grit", owner: owner, commitsURL: "https://api.github.com/repos/mojombo/grit/commits", commits: nil)
        
        let viewModel = RepositoryInfoViewModel(repository: repository)
        XCTAssertEqual(viewModel.repositoryName, repository.name)
        
        guard let stringAvatarURL = owner.avatarURL,
            let avatarURL = URL(string: stringAvatarURL) else {
                XCTFail()
                return
        }
        XCTAssertEqual(viewModel.repositoryOwnerAvatarURL, avatarURL)
        XCTAssertEqual(viewModel.repositoryOwnerLogin, owner.login)
        
        XCTAssertTrue(viewModel.needsMoreInfo)
        
        let firstCommitNodeAuthor = CommitNodeAuthor(name: "Ryan Tomayko", date: "2011-06-15T19:29:14Z")
        let firstCommitNode = CommitNode(author: firstCommitNodeAuthor, message: "ruby rev_list passes --verify to native rev_parse in fallback\n\nOtherwise, the git-rev-parse will return whatever is given as an arg\nwhen the ref doesn't exist. e.g.,\n\n  $ git rev-parse some-bad-ref\n  some-bad-ref\n  fatal: ambiguous argument 'some-bad-ref': unknown revision or path not in the working tree.\n\nThe error message is on stderr and git-rev-parse exits with non-zero\nbut the ref name is still output.\n\nThe problem here is that code often calls rev_list like:\n\n    git.rev_list({}, \"some-bad-ref\")\n\nThen rev_list tries to convert some-bad-ref to a SHA1, gets back the\nref string, but continues on anyway. This eventually results in the\nrev_list failing to look up the object because it assumes its a SHA1\nwhen its really a ref string.")
        let firstCommitParentNode = Commit(sha: "1c03f3e1f822232aeb00833081418391a44fe3df", commit: nil, parents: nil)
        let firstCommit = Commit(sha: "b0135670e0002fee8491ea1e15e7308817e9a255", commit: firstCommitNode, parents: [firstCommitParentNode])
        
        let lastCommitNodeAuthor = CommitNodeAuthor(name: "Brandon Keepers", date: "2014-02-03T19:24:07Z")
        let lastCommitNode = CommitNode(author: lastCommitNodeAuthor, message: "Merge pull request #183 from bkeepers/unmaintained\n\nClearly state the project status")
        let lastCommitParentNode0 = Commit(sha: "b49a6ff4ccd169eef6671263ccb29d3ead957697", commit: nil, parents: nil)
        let lastCommitParentNode1 = Commit(sha: "83d3124f8dc2fbd5542041d1f84e6153612d5ed9", commit: nil, parents: nil)
        let lastCommit = Commit(sha: "5608567286e64a1c55c5e7fcd415364e04f8986e", commit: lastCommitNode, parents: [lastCommitParentNode0, lastCommitParentNode1])
        repository.commits = [lastCommit, firstCommit]
        
        XCTAssertFalse(viewModel.needsMoreInfo)
        
        XCTAssertEqual(viewModel.lastCommitAuthorName, lastCommit.commit?.author.name)
        XCTAssertEqual(viewModel.lastCommitMessage, lastCommit.commit?.message)
        
        let shaParentsString = "\(lastCommitParentNode0.sha)\n\(lastCommitParentNode1.sha)"
        XCTAssertEqual(viewModel.lastCommitShaParents, shaParentsString)
        
        let dateStringToCompareWith = "03.02.2014"
        let isoDateFormatter = ISO8601DateFormatter()
        guard let dateString = lastCommit.commit?.author.date,
            let date = isoDateFormatter.date(from: dateString) else {
                XCTFail()
                return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDateString = dateFormatter.string(from: date)
        XCTAssertEqual(formattedDateString, dateStringToCompareWith)
        
        XCTAssertEqual(viewModel.lastCommitDate, formattedDateString)
        XCTAssertEqual(viewModel.lastCommitDate, dateStringToCompareWith)
    }
    
    // MARK: - Views

    func testAsyncImageView() {
        let asyncImageView = AsyncImageView()
        XCTAssertNil(asyncImageView.image)
        
        let imageDownloadExpectation = expectation(description: "Checking that image is downloaded")
        /// URL example from: https://jsonplaceholder.typicode.com
        guard let imageURL = URL(string: "https://via.placeholder.com/600/92c950") else {
            XCTFail()
            return
        }
        
        asyncImageView.loadImageFrom(url: imageURL) { (result) in
            switch result {
            case .success():
                imageDownloadExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 2) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertNotNil(asyncImageView.image)
        }
    }
    
}
