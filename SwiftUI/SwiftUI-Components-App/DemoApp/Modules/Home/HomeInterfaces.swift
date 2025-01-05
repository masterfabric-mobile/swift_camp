import UIKit

protocol HomeInteractorInterface: AnyObject {
    func fetchRepoInfo(completion: @escaping (GithubRepoInfo) -> Void)
}

protocol HomeWireframeInterface: WireframeInterface {
    func showVStack()
    func showZStack()
    func showContentView()
    func showColorPicker()
    func showRectangle()
    func showSection()
    func showHStack()
    func showNavigationStack()
    func showFrame()
    func showScrollView()
    func showNavigationView()
    func showTransaction()
    func showTabView()
    func showText()
    func showAttributedText()
    func showButton()
    func showDatePicker()
    func showSegmentedControl()
    func showRoundedRectangle()
    func showShadow()
    func showScaleEffect()
    func showAnimation()
    func showLazyHGrid()
    func showLazyVStackView()
    func showMatchedGeometryEffect()
    func showImage()
    func showMenuButton()
    func showCircle()
    func showOpacity()
    func showSecureField()
    func showContextMenu()
    func showBinding()
    func showStepper()
    func showLazyVGridView()
    func showCanvas()
    func showEllipse()
    func showPadding()
    func showLazyHStack()
    func showAlert()
    func showRotationEffect()
    func showWithAnimation()


    func showTextField()
    func showLongPressGesture()

    func showProgressView()

    func showGrid()
    
    
    func showSlider()


    
    func showLabel()

    func showCapsuleView()
    


    func showDivider()

    
    
    func showDragGesture()

    func showBackground()




    func showPicker()
    
    func showCornerRadius()



    func showOffset()

    func showList()


    
    
    func showActionSheet()

    func showTransition()
    
    func showTimeLineView()
    
    func showMap()
    
    
    func showLink()
    
    func showPath()
    func showTapGesture()



    func showGroup()

    
    func showRotationGesture()



    func showMagnificationGesture()
    
    func showForegroundColor()




    
    func showCustomShape()
    
    func showGeometryReader()
    func showPopover()
    func showFocusState()

    
    func showProgressIndicator()

    func showObservedObject()


}
