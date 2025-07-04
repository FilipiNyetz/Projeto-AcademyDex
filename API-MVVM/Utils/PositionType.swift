//
//  PositionType.swift
//  API-MVVM
//
//  Created by Filipi Romão on 01/07/25.
//

enum PositionType {
    case coder
    case mentor
    case designer
    case mentorJr
    case suport
    case unknown

    static func from(id: String) -> PositionType {
        switch id {
        case "7e2f7693-df26-4dcd-9fb1-c39c0b11ecf4": return .coder
        case "8b12014b-9463-4a4f-91e3-ed1fc5bb8ff8": return .mentor
        case "bc8c4ea9-c88f-4f82-a60b-c921536a88b9": return .designer
        case "d69ee0db-32f2-4985-93b6-01e17a713fdc": return .mentorJr
        case "afd64d44-aeeb-42bb-b2f0-0fabc51eda77": return .suport
        default: return .unknown
        }
    }

    var imageName: String {
        switch self {
        case .coder: return "CoderID"
        case .mentor: return "MentorID"
        case .designer: return "DesignerID"
        case .mentorJr: return "MentorJrID"
        case .suport: return "SuportID"
        case .unknown: return "CoderID"
        }
    }
    var imagePerfilPhoto: String {
        switch self {
        case .coder: return "CoderPhoto"
        case .mentor: return "MentorPhoto"
        case .designer: return "DesignerPhoto"
        case .mentorJr: return "MentorJRPhoto"
        case .suport: return "SuportPhoto"
        case .unknown: return "CoderPhoto"
        }
    }
}

