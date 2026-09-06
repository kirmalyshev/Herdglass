import AppKit
import HerdrClient
import Testing

@testable import Herdglass

// MARK: - StatusStyle

/// The dot's vocabulary, pinned per status: green unless an agent is running,
/// and hollow unless there is something to look at. Both views that draw a dot
/// read these two functions, so the mapping is the whole contract.
@Test func statusColorsAreGreenExceptAWorkingAgent() {
    #expect(StatusStyle.color(.working) == .systemOrange)
    #expect(StatusStyle.color(.done) == .systemGreen)
    #expect(StatusStyle.color(.blocked) == .systemGreen)
    #expect(StatusStyle.color(.idle) == .systemGreen)
    #expect(StatusStyle.color(.unknown) == .tertiaryLabelColor)
}

@Test func onlyAnAgentWithSomethingToSayIsFilled() {
    #expect(StatusStyle.isFilled(.working))
    #expect(StatusStyle.isFilled(.done))
    #expect(StatusStyle.isFilled(.blocked))
    #expect(!StatusStyle.isFilled(.idle))
    #expect(!StatusStyle.isFilled(.unknown))
}

/// `idle` and `unknown` are both hollow, so the colour is the only thing left
/// to tell "an agent with nothing to report" from "no agent at all".
@Test func theTwoHollowStatusesAreStillDistinguishable() {
    #expect(StatusStyle.color(.idle) != StatusStyle.color(.unknown))
}

/// The unread ring is a separate signal and keeps its own two colours: it says
/// *why* a pane is asking, which the dot no longer distinguishes now that
/// blocked and done share a colour.
@Test func theAttentionRingStillSeparatesBlockedFromDone() {
    #expect(StatusStyle.attentionColor(.blocked) == .systemOrange)
    #expect(StatusStyle.attentionColor(.done) == .systemBlue)
}
