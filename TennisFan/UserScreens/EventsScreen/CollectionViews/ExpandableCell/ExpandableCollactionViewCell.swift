//
//  CollectionViewExpandableCell.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import UIKit
import Kingfisher
import Alamofire

class ExpandableCollactionViewCell: UICollectionViewListCell {

  
  // MARK: - properties
  static let reusableID: String = String(describing: ExpandableCollactionViewCell.self)
  var event: Event?

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func updateConfiguration(using state: UICellConfigurationState) {
    var newConfiguration = ExpandableContentConfiguration().updated(for: state)
    newConfiguration.homeName = event?.homeTeam?.name
    newConfiguration.awayName = event?.awayTeam?.name
  
    contentConfiguration = newConfiguration
    guard let homeID = event?.homeTeam?.id else { return }
    var url = try? Router.playerImage(playerID: homeID).asURLRequest()
    var requestModifier0 = AnyModifier { request in
      var r = request
      r.setValue("128a63a140mshfd951a8d630513ap1ef303jsnb96e928d33ce", forHTTPHeaderField: "X-RapidAPI-Key")
      return r
    }
    var requestModifier = AnyModifier { request in
      var r = request
      r.setValue("tennisapi1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
      return r
    }
    var image = UIImageView()
    image.kf.setImage(with: url?.url, options: [.requestModifier(requestModifier0)]){result in
      newConfiguration.homeImage = image.image
      self.contentConfiguration = newConfiguration
    }
  }
}


