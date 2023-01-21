//
//  UseCase.swift
//  MVVM-Clean
//
//  Created by MBS on 18/01/2023.
//

import Foundation
import Combine

///Abstraction layer to represent the top usecase for feature
protocol UseCase {
    
}


///this will be as our base use case for having all use cases fetch result function
protocol SingleUseCase{
    func start() -> Future<Response?,ErrorResponse>
}
