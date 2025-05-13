package main

import (
	"testing"
)


func determineWinner(yourSelection, mySelection string) string {
	if yourSelection == mySelection {
		return "Draw"
	}
	if yourSelection == "STONE" && mySelection == "SCISSOR" {
		return "You"
	}
	if yourSelection == "SCISSOR" && mySelection == "BAG" {
		return "You"
	}
	if yourSelection == "BAG" && mySelection == "STONE" {
		return "You"
	}
	return "Computer"
}




func TestDetermineWinner_YouWin(t *testing.T) {
	your := "STONE"
	computer := "SCISSOR"
	expected := "You"

	result := determineWinner(your, computer)
	if result != expected {
		t.Errorf("Expected winner %s, got %s", expected, result)
	}
}


func TestDetermineWinner_Draw(t *testing.T) {
	your := "BAG"
	computer := "BAG"
	expected := "Draw"

	result := determineWinner(your, computer)
	if result != expected {
		t.Errorf("Expected result %s, got %s", expected, result)
	}
}
