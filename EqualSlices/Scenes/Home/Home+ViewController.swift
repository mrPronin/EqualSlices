//
//  Home+ViewController.swift
//  EqualSlices
//
//  Created by Aleksandr Pronin on 29.04.21.
//

import UIKit
import Combine
import ChainLayout
import Then

extension Home {
    class ViewController: UIViewController {
        // MARK: - Public API
        let viewModel: HomeViewModel
        
        // MARK: - Init
        init(viewModel: HomeViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - View Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupOnLoad()
        }
        
        // MARK: - UI
        let scrollView = UIScrollView().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isUserInteractionEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.isPagingEnabled = false
            $0.backgroundColor = .systemBackground
        }
        let stackView = UIStackView().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .vertical
            $0.spacing = 16
        }
        // totalSlices
        let totalSlicesLabel = UILabel().then { $0.text = "Total slices: " }
        let totalSlicesInput = UITextField()
        let totalSlicesView = UIStackView()
        // recipients
        let recipientsLabel = UILabel().then { $0.text = "Recipients: " }
        let recipientsInput = UITextField()
        let recipientsView = UIStackView()
        // perRecipientSlices
        let perRecipientSlicesLabel = UILabel().then { $0.text = "Slices per recipient: " }
        let perRecipientSlicesInput = UITextField()
        let perRecipientSlicesView = UIStackView()
        // output
        let resultLabel = UILabel().then { $0.text = "Result undefined. Please provide values." }

        // MARK: - Private
        var subsciptions = Set<AnyCancellable>()
    }
}

// MARK: - Private
extension Home.ViewController {
    private func bindViewModel() {
        // totalSlicesInput
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: totalSlicesInput)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] in self?.viewModel.totalSlices.send($0) }.store(in: &subsciptions)
        
        // recipientsInput
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: recipientsInput)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] in self?.viewModel.recipients.send($0) }.store(in: &subsciptions)
        
        // perRecipientSlicesInput
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: perRecipientSlicesInput)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] in self?.viewModel.perRecipientSlices.send($0) }.store(in: &subsciptions)

        // output
        viewModel.output
            .map { "Your result: \($0)" }
            .assign(to: \.text, on: resultLabel)
            .store(in: &subsciptions)
    }
    private func setupUI() {
        // scrollView
        scrollView.add(into: view)
            .leading(16)
            .trailing(16)
            .top(32, toSafeArea: true)
            .bottom(toSafeArea: true)
            .done()
        
        // stackView
        stackView.add(into: scrollView)
            .leading()
            .trailing()
            .top()
            .bottom()
            .done()
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        // totalSlices
        totalSlicesView.addArrangedSubview(totalSlicesLabel)
        totalSlicesView.addArrangedSubview(totalSlicesInput)
        stackView.addArrangedSubview(totalSlicesView)

        // recipients
        recipientsView.addArrangedSubview(recipientsLabel)
        recipientsView.addArrangedSubview(recipientsInput)
        stackView.addArrangedSubview(recipientsView)

        // perRecipientSlices
        perRecipientSlicesView.addArrangedSubview(perRecipientSlicesLabel)
        perRecipientSlicesView.addArrangedSubview(perRecipientSlicesInput)
        stackView.addArrangedSubview(perRecipientSlicesView)
        
        // output
        stackView.addArrangedSubview(resultLabel)

        let labels = [totalSlicesLabel, recipientsLabel, perRecipientSlicesLabel, resultLabel]
        labels.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }
        
        let inputs = [totalSlicesInput, recipientsInput, perRecipientSlicesInput]
        inputs.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.keyboardType = .numberPad
            $0.backgroundColor = .white
            $0.borderStyle = .roundedRect
        }
        
        let containers = [totalSlicesView, recipientsView, perRecipientSlicesView]
        containers.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .horizontal
            $0.spacing = 16
        }
    }
    private func setupOnLoad() {
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
    }
}
