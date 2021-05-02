//
//  UICollectionView_Rx.swift
//  LookArt
//
//  Created by xzh on 2021/4/6.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
@available(iOS 13.0,*)
extension Reactive where Base: UICollectionView {
    //collectionView:contextMenuConfigurationForItemAtIndexPath:point:
//    var delegate: DelegateProxy<UICollectionViewDelegate , UICollectionViewDelegateFlowLayout> {
//        RxCollectionViewDelegateProxy.proxy(for: Base)
//    }
    
    var abc: ControlEvent<(() -> UIContextMenuConfiguration?)?> {
        let source: Observable<(() -> UIContextMenuConfiguration?)?> = self.delegate.methodInvoked(#selector(UICollectionViewDelegate.collectionView(_:contextMenuConfigurationForItemAt:point:))).map {
            return $0[0] as? (() -> UIContextMenuConfiguration?)
        }
        return ControlEvent.init(events: source)
    }
    
//    public func items<Sequence: Swift.Sequence, Source: ObservableType>
//        (_ source: Source)
//        -> (_ cellFactory: @escaping (UICollectionView, Int, Sequence.Element) -> UIContextMenuConfiguration?)
//        -> Disposable where Source.Element == Sequence {
//        return { cellFactory in
//            let dataSource = RxCollectionViewReactiveArrayDataSourceSequenceWrapper<Sequence>(cellFactory: cellFactory)
//            return self.items(dataSource: dataSource)(source)
//        }
//
//    }
    
}

@available(iOS 13.0, *)
extension RxCollectionViewDelegateProxy {
    public func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
}
