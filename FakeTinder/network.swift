//
//  netWork.swift
//  FakeTinder
//
//  Created by pearl on 10.07.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import Foundation
import Moya

public enum imageNetwork{
    case getImage
    

}
extension imageNetwork: TargetType{
    public var baseURL: URL {
        
        return URL(string: "https://simplifiedcoding.net")!
    }
    
    public var path: String {
        switch self {
            
        case .getImage:             return "/demos/marvel/"
            
        
       
        }
    }
    
    public var method: Moya.Method {
        switch self {
        
        case .getImage:             return .get
            
      
        }
    }
    
    public var sampleData: Data {
      return  Data()
    }
    
    public var task: Task {
        switch self {
            
        case .getImage:             return .requestPlain
      
        }
    }
    
    public var headers: [String : String]? {
        switch self {
            
        case .getImage:            return ["Content-Type":"application/jason"]
       
        }
    }
    
    
    
}
