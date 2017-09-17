//
// Created by Ran Endelman on 09/09/2017.
// Copyright (c) 2017 RanEndelman. All rights reserved.
//

import Foundation

/* Record Class for FireBase usage with dictionary */
class Record {
    var dict: [String: Any]

    init(score: Int, name: String, long: Double, lat: Double) {
        self.dict = ["score": score, "name": name, "long": long, "lat": lat]
    }

}
