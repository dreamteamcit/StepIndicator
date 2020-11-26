//
//  ViewController.swift
//  StepIndicator
//
//  Created by Yun Chen on 2017/7/14.
//  Copyright © 2017 Yun CHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var stepIndicatorView:StepIndicatorView!
    @IBOutlet weak var scrollView:UIScrollView!
    
    private var isScrollViewInitialized = false
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In this demo, the customizations have been done in Storyboard.
        
        // Customization by coding:
//        self.stepIndicatorView.numberOfSteps = 6
//        self.stepIndicatorView.currentStep = 0
//        self.stepIndicatorView.circleColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
//        self.stepIndicatorView.circleTintColor = .blue
//        self.stepIndicatorView.circleStrokeWidth = 15.0
//        self.stepIndicatorView.circleRadius = 15.0
//        self.stepIndicatorView.lineColor = self.stepIndicatorView.circleColor
//        self.stepIndicatorView.lineTintColor = .black
//        self.stepIndicatorView.lineMargin = 1.0
//        self.stepIndicatorView.lineStrokeWidth = 2.0
//        self.stepIndicatorView.displayNumbers = true //indicates if it displays numbers at the center instead of the core circle
//        self.stepIndicatorView.displayNumberColor = .black
//        self.stepIndicatorView.displayNumberTintColor = .white
//        self.stepIndicatorView.failedCircleColor = .red
//        self.stepIndicatorView.finishedCircleColor = .green
//        self.stepIndicatorView.finishedCircleTintColor = .black
//        self.stepIndicatorView.direction = .leftToRight
//        self.stepIndicatorView.showFlag = true

        // Example for apply constraints programmatically, enable it for test.
//        self.applyNewConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isScrollViewInitialized {
            isScrollViewInitialized = true
            self.initScrollView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initScrollView() {
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * CGFloat(self.stepIndicatorView.numberOfSteps + 1), height: self.scrollView.frame.height)
        
        let labelHeight = self.scrollView.frame.height / 2.0
        let halfScrollViewWidth = self.scrollView.frame.width / 2.0
        
        for i in 1 ... self.stepIndicatorView.numberOfSteps + 1 {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
            if i<=self.stepIndicatorView.numberOfSteps {
                label.text = "\(i)"
            }
            else{
                label.text = "You're done!"
            }
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 35)
            label.textColor = UIColor.lightGray
            label.center = CGPoint(x: halfScrollViewWidth * (CGFloat(i - 1) * 2.0 + 1.0), y:labelHeight)
            self.scrollView.addSubview(label)
        }
    }
    
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
        stepIndicatorView.currentStep = Int(pageIndex)
        currentIndex = Int(pageIndex)
    }
    
    
    // MARK: - More Examples
    
    // Example for applying constraints programmatically
    func applyNewConstraints() {
        // Hold the weak object
        guard let stepIndicatorView = self.stepIndicatorView else {
            return
        }
        
        // Remove the constraints made in Storyboard before
        stepIndicatorView.removeFromSuperview()
        stepIndicatorView.removeConstraints(stepIndicatorView.constraints)
        self.view.addSubview(stepIndicatorView)
        
        // Add new constraints programmatically
        stepIndicatorView.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        stepIndicatorView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        stepIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stepIndicatorView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant:30.0).isActive = true
    
        self.scrollView.topAnchor.constraint(equalTo: stepIndicatorView.bottomAnchor, constant: 48.0).isActive = true
    }
    
    
    @IBAction func setFailedButtonPressed(_ sender: Any) {
        stepIndicatorView.setStepFailed(index: currentIndex)
    }
    
    @IBAction func setFinishedButtonPressed(_ sender: Any) {
        stepIndicatorView.setStepFinished(index: currentIndex)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if currentIndex + 1 <= stepIndicatorView.numberOfSteps {
            if currentIndex + 1 == stepIndicatorView.numberOfSteps {
                stepIndicatorView.setStepFinished(index: currentIndex)
                stepIndicatorView.currentStep = currentIndex + 1
                scrollView.setContentOffset(CGPoint(x: CGFloat(currentIndex+1) * scrollView.frame.size.width, y: scrollView.contentOffset.y), animated: true)
            }
            else {
                currentIndex = currentIndex + 1
                stepIndicatorView.setCurrentStep(index: currentIndex)
                scrollView.setContentOffset(CGPoint(x: CGFloat(currentIndex) * scrollView.frame.size.width, y: scrollView.contentOffset.y), animated: true)
            }
        }
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        if currentIndex - 1 >= 0 {
            if !(currentIndex == stepIndicatorView.numberOfSteps - 1 && stepIndicatorView.currentStep == stepIndicatorView.numberOfSteps) {
                currentIndex = currentIndex - 1
            }
            stepIndicatorView.setCurrentStep(index: currentIndex)
            scrollView.setContentOffset(CGPoint(x: CGFloat(currentIndex) * scrollView.frame.size.width, y: scrollView.contentOffset.y), animated: true)
        }
    }
}

