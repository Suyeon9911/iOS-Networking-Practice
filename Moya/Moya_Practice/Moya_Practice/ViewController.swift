//
//  ViewController.swift
//  Moya_Practice
//
//  Created by 김수연 on 2021/11/22.
//

import UIKit
import Moya
import SnapKit
import Then

class ViewController: UIViewController {

    private var users: [User] = [User]()

    /// Moya Target 과 상호작용하는 MoyaProvider 인스턴스 생성
    /// 제네릭 타입으로 정의하며, TargetType을 채택한 자료형 입력
    /// 이후 request 요청시 MoyaProvider를 통해 접근
    let service = MoyaProvider<UserService>()

    private lazy var tableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    fileprivate lazy var rightBtn = UIBarButtonItem().then {
        $0.image = .add
        $0.target = self
        $0.action = #selector(didTapBarbtn)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Moya Demo"
        self.navigationItem.rightBarButtonItem = self.rightBtn
        setupTableView()
        readUsers()
    }

    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// act when rightBtn did tapped.
    @objc func didTapBarbtn() {
        let suyeon = User(id: 19991120, name: "suyeon", userName: "suyeon")
        createUser(name: suyeon.name)
    }

    /// Completion Handler를 통해서 내부에서 response로 넘어온 데이터를 필요에 따라 가공
    private func readUsers() {
        service.request(UserService.readUsers) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                do {
                    /// 성공 시, user 데이터 디코딩
                    let users = try JSONDecoder().decode([User].self, from: response.data)
                    self.users = users
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    /// update user data.
    /// - Parameters:
    ///   - id: user's id
    ///   - name: user's name
    ///   - indexPath: user's indexPath
    fileprivate func updateUser(id: Int, name: String, indexPath: IndexPath) {
        service.request(UserService.updateUser(id: id, name: "[Modified]" + name)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let modifiedUser = try JSONDecoder().decode(User.self, from: response.data)
                    self.users[indexPath.row] = modifiedUser
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }

            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    

    fileprivate func createUser(name: String) {
        service.request(UserService.createUser(name: name)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let newUser = try JSONDecoder().decode(User.self, from: response.data)
                    self.users.insert(newUser, at: 0)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }

    /// delete selected user.
    /// - Parameters:
    ///   - id: user's id
    ///   - indexPath: user's indexPath
    fileprivate func deleteUser(id: Int, indexPath: IndexPath) {
        service.request(UserService.deleteUser(id: id)) { result in
            switch result {
            case .success(let response):
                print("Delete: \(response)")
                self.users.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)

            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}

// Datasource Methods.
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        updateUser(id: user.id, name: user.name, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let user = users[indexPath.row]
        deleteUser(id: user.id, indexPath: indexPath)
    }
}

