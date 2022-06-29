# Le-Baluchon
Le Baluchon vous permet d'obtenir le taux de change, la météo locale et des traductions.

------------------------------------------------------------------------------------

To make every functionnality work you have to provide an api key for Fixer API, OpenWeatherMap API and Google Translation API. To do so, create a file Constant.swift.

Create the following structure:

struct Constant {
    
    static let OpenWeatherMapAppId = "YOUR APP ID"
    
    static let FixerApiKey = "YOUR API KEY"
    
    static let GoogleranslationApiKey = "YOUR API KEY"
}
