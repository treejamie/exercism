// Package weather provides a forecast for a set of
// current conditions in a current location.
package weather


var (
	// CurrentCondition represents the weather conditions as a string.
	CurrentCondition string
	// CurrentLocation represents the current location as a string.
	CurrentLocation  string
)
// Forecast returns a string that contains a forecast.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
