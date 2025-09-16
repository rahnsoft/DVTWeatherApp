
import Foundation

enum Strings: String {
    // MARK: Common

    case commonTitle = "Common_title"
    case commonHome = "Common_Home"
    case commonSave = "Common_Save"
    case commonOkay = "Common_Okay"
    case commonCancel = "Common_Cancel"
    case commonGotIt = "Common_GotIt"
    case commonContinue = "Common_Continue"
    case commonTryAgain = "Common_TryAgain"
    case commonTryAgainCount = "Common_TryAgain_Count"
    case commonTryAgainLater = "Common_TryAgainLater"
    case commonRetry = "Common_Retry"
    case commonTotal = "Common_Total"
    case commonInfo = "Common_Info"
    case commonProceed = "Common_Proceed"
    case commonVerify = "Common_Verify"
    case commonSendAgain = "Common_Send_Again"
    case commonTermsAndConditions = "Common_Terms_Conditions"
    case commonName = "Common_Name"
    case commonEmail = "Common_email"
    case commonSomethingWentWrong = "Common_something_went_wrong"
    case commonWeHitAsnag = "Common_we_hit_a_snag"
    case commonYouVeBeenLoggedOut = "Common_You_ve_been_logged_out"
    case commonSignedOut = "Common_signed_out"
    case favourites = "Common_favourites"
    case skip = "Common_skip"

    // MARK: Errors

    case commonGeneralError = "Common_GeneralError"
    case commonInternetError = "Common_InternetError"
    case commonInternetErrorDesc = "Common_InternetError_Desc"
    case invalidPhoneNumberError = "Invalid_PhoneNumber"
    case invalidMeterNumberError = "Invalid_Bill_Number"
    case commonCheckInternet = "Common_check_internet"

    // MARK: Get Started

    case HomeOneTitle = "Get_Started_one_title"
    case HomeOneSubTitle = "Get_Started_one_subTitle"
    case HomeTwoTitle = "Get_Started_two_title"
    case HomeTwoSubTitle = "Get_Started_tow_subTitle"
    case HomeThreeTitle = "Get_Started_three_title"
    case HomeThreeSubTitle = "Get_Started_three_subTitle"
    case Home = "Get_Started"
    case HomeExcl = "Get_Started!"
    case favoriteSaved = "Favorite_saved"
    case weather_tab = "weather_tab"
    case forecast_tab = "forecast_tab"
    case favorites_tab = "favorites_tab"
    case map_tab = "map_tab"
    case loading_weather = "loading_weather"
    case offline_message = "offline_message"

    func localized() -> String {
        return NSLocalizedString(rawValue, comment: "")
    }

    func localized(with arg: String) -> String {
        return String.localizedStringWithFormat(localized(), arg)
    }

    func localized(with arg: Int) -> String {
        return String.localizedStringWithFormat(localized(), arg)
    }

    func localized(with arg: Double) -> String {
        return String.localizedStringWithFormat(localized(), arg)
    }

    func localized(with args: [CVarArg]) -> String {
        return String(format: localized(), args)
    }

    func localized(with args: CVarArg...) -> String {
        return String(format: localized(), args)
    }
}
