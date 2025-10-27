// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation   //allows for API calls
import UserNotifications //for sending notifications with NotificationManager class

//Data models

struct ExperimentData : Codable {
    let id: UUID
    let notificationSentTime: Date
    let notificationMessage: String
    let notificationClickedTime: Date?
    let completionTime: TimeInterval?
    let participantId: String
}

struct MathAnswer: Codable {
    let question: String
    let userAnswer: Int
    let correctAnswer: Int
    let isCorrect: Bool
}

//First run: saves participant Id in UserDefaults
//Second run: recognizes participant Id and will sort associated data
func getParticipantId() -> String {
    let defaults = UserDefaults.standard
    if let existingId = defaults.string(forKey: "participantId") {
        return existingId
    } else {
        let newId = String(UUID().uuidString.prefix(8).lowercased())
        defaults.set(newId, forKey: "participantId")
        return newId
    }
}

func testDataModels(){
    print("testing data models")

    let sampleAnswer = MathAnswer(
        question: "5 + 3 = ?", userAnswer: 8, correctAnswer: 8, isCorrect: true
    )
    let sampleData = ExperimentData(
        id: UUID(), notificationSentTime: Date(), notificationMessage: "Test notif", notificationClickedTime: Date(), completionTime: 15.0, participantId: getParticipantId()
    )

    print("Sample Math Answer created: ")
    print("Question: \(sampleAnswer.question)")
    print("Answer: \(sampleAnswer.userAnswer)")

    print("Sample Experiment data created: ")
    print("participant id: \(sampleData.participantId)")
    print("notification message: \(sampleData.notificationMessage)")

    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(sampleData)
        if let jsonString = String(data:jsonData, encoding:.utf8){
            print("JSON encoding success")
            print("JSON structure samp:")
            print(jsonString)
        }
    } catch {
        print("JSON encoding failed")
    }
}

testDataModels()