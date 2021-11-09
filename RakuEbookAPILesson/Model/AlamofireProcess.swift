//
//  AlamofireProcess.swift
//  RakuEbookAPILesson
//
//  Created by UrataHiroki on 2021/11/09.
//

import Alamofire
import SwiftyJSON


class AlamofireProcess{
    
    private var privateMediumImageUrl:String?
    private var privateTitle:String?
    private var privateAuthor:String?
    private var privateItemCaption:String?
    
    private var resultEbookDetailArray = [EbookDetailDatas]()
}

extension AlamofireProcess{
    
    public func getEbookDetailData(searchKeyWord:String?,completion: @escaping ([EbookDetailDatas]?,Error?) -> Void){
        
        guard let keyword = searchKeyWord else { return }
        
        let apiKey = ""
        
        AF.request(apiKey, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {[self] response in
            
            switch response.result{
                
            case .success:
                
                let detailData = JSON(response.data as Any)
                
                for dataCount in 0..<detailData["items"].count{
                    
                    getDataNilCheck(mediumImageUrlCheck: detailData["items"][dataCount]["item"]["mediumImageUrl"].string,
                                    titleCheck: detailData["items"][dataCount]["item"]["title"].string,
                                    authorCheck: detailData["items"][dataCount]["item"]["author"].string,
                                    itemCaptionCheck: detailData["items"][dataCount]["item"]["itemCaption"].string)
                    
                    resultEbookDetailArray.append(EbookDetailDatas(mediumImageUrl: privateMediumImageUrl,
                                                                   title: privateTitle,
                                                                   author: privateAuthor,
                                                                   itemCaption: privateItemCaption))
                }
                
                completion(resultEbookDetailArray, nil)
                
                
            case .failure(let error):
                
                completion(nil, error)
            }
        }
        
    }
}

extension AlamofireProcess{
    
    private func getDataNilCheck(mediumImageUrlCheck:String?,titleCheck:String?,authorCheck:String?,itemCaptionCheck:String?){
        
        if mediumImageUrlCheck != nil{
            
            privateMediumImageUrl = mediumImageUrlCheck
        }else{
            
            privateMediumImageUrl = "nosign"
        }
        
        if titleCheck != nil{
            
            privateTitle = titleCheck
        }else{
            
            privateTitle = "読み込みエラー"
        }
        
        if authorCheck != nil{
            
            privateAuthor = authorCheck
        }else{
            
            privateAuthor = "読み込みエラー"
        }
        
        if itemCaptionCheck != nil{
            
            privateItemCaption = itemCaptionCheck
        }else{
            
            privateItemCaption = "読み込みエラー"
        }
        
        
    }
}


extension String{
    
    var urlEncoded:String{
        
        let charset = CharacterSet.alphanumerics.union(.init(charactersIn: "/?-._~"))
        let remove = removingPercentEncoding ?? self
        
        return remove.addingPercentEncoding(withAllowedCharacters: charset) ?? remove
    }
}
