import RxSwift
import RxCocoa
import RxSwiftExt
extension Reactive where Base: UIViewController {

    public var viewDidLoad: Observable<Void> {
        let selector = #selector(base.viewDidLoad)
        return base.rx.methodInvoked(selector).mapTo(Void())
    }

    public var viewWillAppear: Observable<Void> {
        let selector = #selector(base.viewWillAppear(_:))
        return base.rx.methodInvoked(selector).mapTo(Void())
    }

    public var viewDidAppear: Observable<Void> {
        let selector = #selector(base.viewDidAppear(_:))
        return base.rx.methodInvoked(selector).mapTo(Void())
    }

    public var viewWillDisappear: Observable<Void> {
        let selector = #selector(base.viewWillDisappear(_:))
        return base.rx.methodInvoked(selector).mapTo(Void())
    }

    public var viewDidDisappear: Observable<Void> {
        let selector = #selector(base.viewDidDisappear(_:))
        return base.rx.methodInvoked(selector).mapTo(Void())
    }

    public var willMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = self.methodInvoked(#selector(Base.willMove)).map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }

    public var didMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = self.methodInvoked(#selector(Base.didMove)).map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
}

