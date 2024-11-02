//
//  Data.swift
//  Visited
//
//  Created by Kennan Mell on 4/7/24.
//

import UIKit

enum VisitedStatus: Int, Codable {
    case none, visited, wantToGo

    var description: String {
        switch self {
        case .none: return .notVisited
        case .visited: return .visited
        case .wantToGo: return .wantToGo
        }
    }

    var color: UIColor {
        switch self {
        case .none: return .notVisited
        case .visited: return .visited
        case .wantToGo: return .wantToGo
        }
    }
}

class Location {
    let visitedStatus: VisitedStatus
    let year: Int?
    let notes: String?
    
    var dict: [String : Any] {
        var result = [String : Any]()
        result["visitedStatus"] = visitedStatus.rawValue
        if let year {
            result["year"] = year
        }
        if let notes {
            result["notes"] = notes
        }
        return result
    }
    
    init(visitedStatus: VisitedStatus, year: Int?, notes: String?) {
        self.visitedStatus = visitedStatus
        self.year = year
        self.notes = notes
    }

    init(dict: [String : Any]) {
        if let visitedRaw = dict[Keys.visitedStatus.rawValue] as? Int {
            visitedStatus = VisitedStatus(rawValue: visitedRaw) ?? .none
        } else {
            visitedStatus = .none
        }
        year = dict[Keys.year.rawValue] as? Int
        notes = dict[Keys.notes.rawValue] as? String
    }
            
    private enum Keys: String {
        case visitedStatus = "visitedStatus"
        case year = "year"
        case notes = "notes"
    }
}

enum MapType {
    case world, usa
    static let all: [MapType] = [.world, .usa]
    
    var displayName: String {
        switch self {
        case .world: return .world
        case .usa: return .usa
        }
    }
    
    var imageName: String {
        switch self {
        case .world: return "map_world"
        case .usa: return "map_usa"
        }
    }
    
    var tabBarImage: UIImage? {
        switch self {
        case .world: return UIImage(systemName: "globe.europe.africa")
        case .usa: return UIImage(systemName: "globe.americas")
        }
    }
}

class MapData {
    let mapType: MapType
    let sortedKeys: [String]

    init(mapType: MapType) {
        self.mapType = mapType
        switch mapType {
        case .usa: sortedKeys = MapData.sortedUSAStates
        case .world: sortedKeys = MapData.sortedWorldCountries
        }
    }

    func displayName(for key: String) -> String {
        switch mapType {
        case .usa: return MapData.usaStates[key]!
        case .world: return MapData.worldCountries[key]!
        }
    }

    private static let sortedUSAStates = usaStates.keys.sorted { lhs, rhs in
        guard let left = usaStates[lhs], let right = usaStates[rhs] else {
            assertionFailure()
            return false
        }
        return left < right
    }
    
    private static let usaStates = [
        "US-AK": "Alaska",
        "US-AL": "Alabama",
        "US-AR": "Arkansas",
        "US-AZ": "Arizona",
        "US-CA": "California",
        "US-CO": "Colorado",
        "US-CT": "Connecticut",
        "US-DC": "District of Columbia",
        "US-DE": "Delaware",
        "US-FL": "Florida",
        "US-GA": "Georgia",
        "US-HI": "Hawaii",
        "US-IA": "Iowa",
        "US-ID": "Idaho",
        "US-IL": "Illinois",
        "US-IN": "Indiana",
        "US-KS": "Kansas",
        "US-KY": "Kentucky",
        "US-LA": "Louisiana",
        "US-MA": "Massachusetts",
        "US-MD": "Maryland",
        "US-ME": "Maine",
        "US-MI": "Michigan",
        "US-MN": "Minnesota",
        "US-MO": "Missouri",
        "US-MS": "Mississippi",
        "US-MT": "Montana",
        "US-NC": "North Carolina",
        "US-ND": "North Dakota",
        "US-NE": "Nebraska",
        "US-NH": "New Hampshire",
        "US-NJ": "New Jersey",
        "US-NM": "New Mexico",
        "US-NV": "Nevada",
        "US-NY": "New York",
        "US-OH": "Ohio",
        "US-OK": "Oklahoma",
        "US-OR": "Oregon",
        "US-PA": "Pennsylvania",
        "US-RI": "Rhode Island",
        "US-SC": "South Carolina",
        "US-SD": "South Dakota",
        "US-TN": "Tennessee",
        "US-TX": "Texas",
        "US-UT": "Utah",
        "US-VA": "Virginia",
        "US-VT": "Vermont",
        "US-WA": "Washington",
        "US-WI": "Wisconsin",
        "US-WV": "West Virginia",
        "US-WY": "Wyoming"
    ]

    private static let sortedWorldCountries = worldCountries.keys.sorted { lhs, rhs in
        guard let left = worldCountries[lhs], let right = worldCountries[rhs] else {
            assertionFailure()
            return false
        }
        return left < right
    }

    private static let worldCountries = [
        "AE": "United Arab Emirates",
        "AF": "Afghanistan",
        "AL": "Albania",
        "AM": "Armenia",
        "AO": "Angola",
        "AR": "Argentina",
        "AT": "Austria",
        "AU": "Australia",
        "AZ": "Azerbaijan",
        "BA": "Bosnia And Herzegovina",
        "BD": "Bangladesh",
        "BE": "Belgium",
        "BF": "Burkina Faso",
        "BG": "Bulgaria",
        "BI": "Burundi",
        "BJ": "Benin",
        "BN": "Brunei Darussalam",
        "BO": "Bolivia",
        "BR": "Brazil",
        "BS": "Bahamas",
        "BT": "Bhutan",
        "BW": "Botswana",
        "BY": "Belarus",
        "BZ": "Belize",
        "CA": "Canada",
        "CD": "The Democratic Republic Of The Congo",
        "CF": "Central African Republic",
        "CG": "Republic Of The Congo",
        "CH": "Switzerland",
        "CI": "Cote D'ivoire",
        "CL": "Chile",
        "CM": "Cameroon",
        "CN": "China",
        "CO": "Colombia",
        "CR": "Costa Rica",
        "CU": "Cuba",
        "CY": "Cyprus",
        "CZ": "Czech Republic",
        "DE": "Germany",
        "DJ": "Djibouti",
        "DK": "Denmark",
        "DO": "Dominican Republic",
        "DZ": "Algeria",
        "EC": "Ecuador",
        "EE": "Estonia",
        "EG": "Egypt",
        "EH": "Western Sahara",
        "ER": "Eritrea",
        "ES": "Spain",
        "ET": "Ethiopia",
        "FK": "Falkland Islands",
        "FI": "Finland",
        "FJ": "Fiji",
        "FR": "France",
        "GA": "Gabon",
        "GB": "Great Britain",
        "GE": "Georgia",
        "GF": "French Guiana",
        "GH": "Ghana",
        "GL": "Greenland",
        "GM": "Gambia",
        "GN": "Guinea",
        "GQ": "Equatorial Guinea",
        "GR": "Greece",
        "GT": "Guatemala",
        "GW": "Guinea-bissau",
        "GY": "Guyana",
        "HN": "Honduras",
        "HR": "Croatia",
        "HT": "Haiti",
        "HU": "Hungary",
        "ID": "Indonesia",
        "IE": "Ireland",
        "IL": "Israel",
        "IN": "India",
        "IQ": "Iraq",
        "IR": "Islamic Republic Of Iran",
        "IS": "Iceland",
        "IT": "Italy",
        "JM": "Jamaica",
        "JO": "Hashemite Kingdom Of Jordan",
        "JP": "Japan",
        "KE": "Kenya",
        "KG": "Kyrgyzstan",
        "KH": "Cambodia",
        "KP": "North Korea",
        "KR": "South Korea",
        "XK": "Kosovo",
        "KW": "Kuwait",
        "KZ": "Kazakhstan",
        "LA": "Lao People's Democratic Republic",
        "LB": "Lebanon",
        "LK": "Sri Lanka",
        "LR": "Liberia",
        "LS": "Lesotho",
        "LT": "Lithuania",
        "LU": "Luxembourg",
        "LV": "Latvia",
        "LY": "Libya",
        "MA": "Morocco",
        "MD": "Moldova",
        "ME": "Montenegro",
        "MG": "Madagascar",
        "MK": "Macedonia",
        "ML": "Mali",
        "MM": "Myanmar",
        "MN": "Mongolia",
        "MR": "Mauritania",
        "MW": "Malawi",
        "MX": "Mexico",
        "MY": "Malaysia",
        "MZ": "Mozambique",
        "NA": "Namibia",
        "NC": "New Caledonia",
        "NE": "Niger",
        "NG": "Nigeria",
        "NI": "Nicaragua",
        "NL": "Netherlands",
        "NO": "Norway",
        "NP": "Nepal",
        "NZ": "New Zealand",
        "OM": "Oman",
        "PA": "Panama",
        "PE": "Peru",
        "PG": "Papua New Guinea",
        "PH": "Philippines",
        "PL": "Poland",
        "PK": "Pakistan",
        "PR": "Puerto Rico",
        "PS": "State Of Palestine",
        "PT": "Portugal",
        "PY": "Paraguay",
        "QA": "Qatar",
        "RO": "Romania",
        "RS": "Serbia",
        "RU": "Russia",
        "RW": "Rwanda",
        "SA": "Saudi Arabia",
        "SB": "Solomon Islands",
        "SD": "Sudan",
        "SE": "Sweden",
        "SI": "Slovenia",
        "SJ": "Svalbard And Jan Mayen",
        "SK": "Slovakia",
        "SL": "Sierra Leone",
        "SN": "Senegal",
        "SO": "Somalia",
        "SR": "Suriname",
        "SS": "South Sudan",
        "SV": "El Salvador",
        "SY": "Syrian Arab Republic",
        "SZ": "Swaziland",
        "TD": "Chad",
        "TF": "French Southern Territories",
        "TG": "Togo",
        "TH": "Thailand",
        "TJ": "Tajikistan",
        "TL": "Timor-leste",
        "TM": "Turkmenistan",
        "TN": "Tunisia",
        "TR": "Turkey",
        "TT": "Trinidad And Tobago",
        "TW": "Taiwan",
        "TZ": "United Republic Of Tanzania",
        "UA": "Ukraine",
        "UG": "Uganda",
        "US": "United States",
        "UY": "Uruguay",
        "UZ": "Uzbekistan",
        "VE": "Venezuela",
        "VN": "Viet Nam",
        "VU": "Vanuatu",
        "YE": "Yemen",
        "ZA": "South Africa",
        "ZM": "Zambia",
        "ZW": "Zimbabwe"
    ]
}
