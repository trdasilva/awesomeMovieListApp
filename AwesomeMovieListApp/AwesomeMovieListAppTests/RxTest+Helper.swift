//
//  RxTest+Helper.swift
//  AwesomeMovieListAppTests
//
//  Created by Tomaz Rocha Silva on 12/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//
import RxSwift
import RxTest
import RxCocoa

extension TestScheduler {
    /// Creates a `TestableObserver` instance which immediately subscribes
    /// to the `source` and disposes the subscription at virtual time 100000.
    func record<O: ObservableConvertibleType>(_ source: O) -> TestableObserver<O.E> {
        let observer = self.createObserver(O.E.self)
        let disposable = source.asObservable().bind(to: observer)
        self.scheduleAt(100000) {
            disposable.dispose()
        }
        return observer
    }
}
