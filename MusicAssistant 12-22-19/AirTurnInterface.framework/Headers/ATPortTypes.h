//
//  ATPortTypes.h
//  ATShared
//
//  Created by Nick Brook on 21/03/2017.
//  Copyright © 2017 AirTurn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(uint8_t, ATPortConfigSequenceType) {
    ATPortConfigSequenceTypeSequence = 0,
    ATPortConfigSequenceTypeCombination = 1,
    ATPortConfigSequenceTypeMaximum = ATPortConfigSequenceTypeCombination
};

typedef NS_OPTIONS(uint8_t, ATPortConfigItemModifier) {
    ATPortConfigItemModifierLeftCtrl     = 1 << 0,
    ATPortConfigItemModifierLeftShift    = 1 << 1,
    ATPortConfigItemModifierLeftAlt      = 1 << 2,
    ATPortConfigItemModifierLeftGui      = 1 << 3,
    ATPortConfigItemModifierRightCtrl    = 1 << 4,
    ATPortConfigItemModifierRightShift   = 1 << 5,
    ATPortConfigItemModifierRightAlt     = 1 << 6,
    ATPortConfigItemModifierRightGui     = 1 << 7,
    ATPortConfigItemModifierCtrlMask     = ATPortConfigItemModifierLeftCtrl | ATPortConfigItemModifierRightCtrl,
    ATPortConfigItemModifierShiftMask    = ATPortConfigItemModifierLeftShift | ATPortConfigItemModifierRightShift,
    ATPortConfigItemModifierAltMask      = ATPortConfigItemModifierLeftAlt | ATPortConfigItemModifierRightAlt,
    ATPortConfigItemModifierGuiMask      = ATPortConfigItemModifierLeftGui | ATPortConfigItemModifierRightGui
};

typedef NS_ENUM(uint8_t, ATPortConfigItemType) {
    ATPortConfigItemTypeKeyboard = 0,
    ATPortConfigItemTypeConsumer = 1,
    ATPortConfigItemTypeMouseMomentary = 2,
    ATPortConfigItemTypeMouseToggle = 3,
    ATPortConfigItemTypeMinimum = ATPortConfigItemTypeKeyboard,
    ATPortConfigItemTypeMaximum = ATPortConfigItemTypeMouseToggle
};

typedef uint16_t ATPortConfigItemCode;

typedef NS_ENUM(ATPortConfigItemCode, ATPortConfigItemCodeKeyboard) {
    ATPortConfigItemCodeKeyboardNoEventIndicated = 0x00,
    ATPortConfigItemCodeKeyboardErrorRollOver = 0x01,
    ATPortConfigItemCodeKeyboardPOSTFail = 0x02,
    ATPortConfigItemCodeKeyboardErrorUndefined = 0x03,
    ATPortConfigItemCodeKeyboardaAndA = 0x04,
    ATPortConfigItemCodeKeyboardbAndB = 0x05,
    ATPortConfigItemCodeKeyboardcAndC = 0x06,
    ATPortConfigItemCodeKeyboarddAndD = 0x07,
    ATPortConfigItemCodeKeyboardeAndE = 0x08,
    ATPortConfigItemCodeKeyboardfAndF = 0x09,
    ATPortConfigItemCodeKeyboardgAndG = 0x0A,
    ATPortConfigItemCodeKeyboardhAndH = 0x0B,
    ATPortConfigItemCodeKeyboardiAndI = 0x0C,
    ATPortConfigItemCodeKeyboardjAndJ = 0x0D,
    ATPortConfigItemCodeKeyboardkAndK = 0x0E,
    ATPortConfigItemCodeKeyboardlAndL = 0x0F,
    ATPortConfigItemCodeKeyboardmAndM = 0x10,
    ATPortConfigItemCodeKeyboardnAndN = 0x11,
    ATPortConfigItemCodeKeyboardoAndO = 0x12,
    ATPortConfigItemCodeKeyboardpAndP = 0x13,
    ATPortConfigItemCodeKeyboardqAndQ = 0x14,
    ATPortConfigItemCodeKeyboardrAndR = 0x15,
    ATPortConfigItemCodeKeyboardsAndS = 0x16,
    ATPortConfigItemCodeKeyboardtAndT = 0x17,
    ATPortConfigItemCodeKeyboarduAndU = 0x18,
    ATPortConfigItemCodeKeyboardvAndV = 0x19,
    ATPortConfigItemCodeKeyboardwAndW = 0x1A,
    ATPortConfigItemCodeKeyboardxAndX = 0x1B,
    ATPortConfigItemCodeKeyboardyAndY = 0x1C,
    ATPortConfigItemCodeKeyboardzAndZ = 0x1D,
    ATPortConfigItemCodeKeyboard1AndExclamation = 0x1E,
    ATPortConfigItemCodeKeyboard2AndAtSymbol = 0x1F,
    ATPortConfigItemCodeKeyboard3AndHash = 0x20,
    ATPortConfigItemCodeKeyboard4AndDollar = 0x21,
    ATPortConfigItemCodeKeyboard5AndPercent = 0x22,
    ATPortConfigItemCodeKeyboard6AndChevron = 0x23,
    ATPortConfigItemCodeKeyboard7AndAmpersand = 0x24,
    ATPortConfigItemCodeKeyboard8AndAsterisk = 0x25,
    ATPortConfigItemCodeKeyboard9AndLeftRoundBrace = 0x26,
    ATPortConfigItemCodeKeyboard0AndRightRoundBrace = 0x27,
    ATPortConfigItemCodeKeyboardReturnENTER = 0x28,
    ATPortConfigItemCodeKeyboardESCAPE = 0x29,
    ATPortConfigItemCodeKeyboardDELETEBackspace = 0x2A,
    ATPortConfigItemCodeKeyboardTab = 0x2B,
    ATPortConfigItemCodeKeyboardSpacebar = 0x2C,
    ATPortConfigItemCodeKeyboardDashAndUnderscore = 0x2D,
    ATPortConfigItemCodeKeyboardEqualSignAndPlus = 0x2E,
    ATPortConfigItemCodeKeyboardLeftSquareBraceAndLeftCurlyBrace = 0x2F,
    ATPortConfigItemCodeKeyboardLeftSquareBraceAndRightCurlyBrace = 0x30,
    ATPortConfigItemCodeKeyboardBackslashAndVerticalLine = 0x31,
    ATPortConfigItemCodeKeyboardNonUSHashAndTilde = 0x32,
    ATPortConfigItemCodeKeyboardSemicolonAndColon = 0x33,
    ATPortConfigItemCodeKeyboardQuoteAndDoubleQuote = 0x34,
    ATPortConfigItemCodeKeyboardGraveAccentAndTilde = 0x35,
    ATPortConfigItemCodeKeyboardCommaAndLeftArrow = 0x36,
    ATPortConfigItemCodeKeyboardPeriodAndRightArrow = 0x37,
    ATPortConfigItemCodeKeyboardForwardSlashAndQuestionMark = 0x38,
    ATPortConfigItemCodeKeyboardCapsLock = 0x39,
    ATPortConfigItemCodeKeyboardF1 = 0x3A,
    ATPortConfigItemCodeKeyboardF2 = 0x3B,
    ATPortConfigItemCodeKeyboardF3 = 0x3C,
    ATPortConfigItemCodeKeyboardF4 = 0x3D,
    ATPortConfigItemCodeKeyboardF5 = 0x3E,
    ATPortConfigItemCodeKeyboardF6 = 0x3F,
    ATPortConfigItemCodeKeyboardF7 = 0x40,
    ATPortConfigItemCodeKeyboardF8 = 0x41,
    ATPortConfigItemCodeKeyboardF9 = 0x42,
    ATPortConfigItemCodeKeyboardF10 = 0x43,
    ATPortConfigItemCodeKeyboardF11 = 0x44,
    ATPortConfigItemCodeKeyboardF12 = 0x45,
    ATPortConfigItemCodeKeyboardPrintScreen = 0x46,
    ATPortConfigItemCodeKeyboardScrollLock = 0x47,
    ATPortConfigItemCodeKeyboardPause = 0x48,
    ATPortConfigItemCodeKeyboardInsert = 0x49,
    ATPortConfigItemCodeKeyboardHome = 0x4A,
    ATPortConfigItemCodeKeyboardPageUp = 0x4B,
    ATPortConfigItemCodeKeyboardDeleteForward = 0x4C,
    ATPortConfigItemCodeKeyboardEnd = 0x4D,
    ATPortConfigItemCodeKeyboardPageDown = 0x4E,
    ATPortConfigItemCodeKeyboardRightArrow = 0x4F,
    ATPortConfigItemCodeKeyboardLeftArrow = 0x50,
    ATPortConfigItemCodeKeyboardDownArrow = 0x51,
    ATPortConfigItemCodeKeyboardUpArrow = 0x52,
    ATPortConfigItemCodeKeyboardKeypadNumLockAndClear = 0x53,
    ATPortConfigItemCodeKeyboardKeypadForwardSlash = 0x54,
    ATPortConfigItemCodeKeyboardKeypadAsterisk = 0x55,
    ATPortConfigItemCodeKeyboardKeypadMinus = 0x56,
    ATPortConfigItemCodeKeyboardKeypadPlus = 0x57,
    ATPortConfigItemCodeKeyboardKeypadENTER = 0x58,
    ATPortConfigItemCodeKeyboardKeypad1AndEnd = 0x59,
    ATPortConfigItemCodeKeyboardKeypad2AndDownArrow = 0x5A,
    ATPortConfigItemCodeKeyboardKeypad3AndPageDn = 0x5B,
    ATPortConfigItemCodeKeyboardKeypad4AndLeftArrow = 0x5C,
    ATPortConfigItemCodeKeyboardKeypad5 = 0x5D,
    ATPortConfigItemCodeKeyboardKeypad6AndRightArrow = 0x5E,
    ATPortConfigItemCodeKeyboardKeypad7AndHome = 0x5F,
    ATPortConfigItemCodeKeyboardKeypad8AndUpArrow = 0x60,
    ATPortConfigItemCodeKeyboardKeypad9AndPageUp = 0x61,
    ATPortConfigItemCodeKeyboardKeypad0AndInsert = 0x62,
    ATPortConfigItemCodeKeyboardKeypadAndDelete = 0x63,
    ATPortConfigItemCodeKeyboardNonUSAnd = 0x64,
    ATPortConfigItemCodeKeyboardApplication = 0x65,
    ATPortConfigItemCodeKeyboardPower = 0x66,
    ATPortConfigItemCodeKeyboardKeypadEqual = 0x67,
    ATPortConfigItemCodeKeyboardF13 = 0x68,
    ATPortConfigItemCodeKeyboardF14 = 0x69,
    ATPortConfigItemCodeKeyboardF15 = 0x6A,
    ATPortConfigItemCodeKeyboardF16 = 0x6B,
    ATPortConfigItemCodeKeyboardF17 = 0x6C,
    ATPortConfigItemCodeKeyboardF18 = 0x6D,
    ATPortConfigItemCodeKeyboardF19 = 0x6E,
    ATPortConfigItemCodeKeyboardF20 = 0x6F,
    ATPortConfigItemCodeKeyboardF21 = 0x70,
    ATPortConfigItemCodeKeyboardF22 = 0x71,
    ATPortConfigItemCodeKeyboardF23 = 0x72,
    ATPortConfigItemCodeKeyboardF24 = 0x73,
    ATPortConfigItemCodeKeyboardExecute = 0x74,
    ATPortConfigItemCodeKeyboardHelp = 0x75,
    ATPortConfigItemCodeKeyboardMenu = 0x76,
    ATPortConfigItemCodeKeyboardSelect = 0x77,
    ATPortConfigItemCodeKeyboardStop = 0x78,
    ATPortConfigItemCodeKeyboardAgain = 0x79,
    ATPortConfigItemCodeKeyboardUndo = 0x7A,
    ATPortConfigItemCodeKeyboardCut = 0x7B,
    ATPortConfigItemCodeKeyboardCopy = 0x7C,
    ATPortConfigItemCodeKeyboardPaste = 0x7D,
    ATPortConfigItemCodeKeyboardFind = 0x7E,
    ATPortConfigItemCodeKeyboardMute = 0x7F,
    ATPortConfigItemCodeKeyboardVolumeUp = 0x80,
    ATPortConfigItemCodeKeyboardVolumeDown = 0x81,
    ATPortConfigItemCodeKeyboardLockingCapsLock = 0x82,
    ATPortConfigItemCodeKeyboardLockingNumLock = 0x83,
    ATPortConfigItemCodeKeyboardLockingScrollLock = 0x84,
    ATPortConfigItemCodeKeyboardKeypadComma = 0x85,
    ATPortConfigItemCodeKeyboardKeypadEqualSign = 0x86,
    ATPortConfigItemCodeKeyboardInternational1 = 0x87,
    ATPortConfigItemCodeKeyboardInternational2 = 0x88,
    ATPortConfigItemCodeKeyboardInternational3 = 0x89,
    ATPortConfigItemCodeKeyboardInternational4 = 0x8A,
    ATPortConfigItemCodeKeyboardInternational5 = 0x8B,
    ATPortConfigItemCodeKeyboardInternational6 = 0x8C,
    ATPortConfigItemCodeKeyboardInternational7 = 0x8D,
    ATPortConfigItemCodeKeyboardInternational8 = 0x8E,
    ATPortConfigItemCodeKeyboardInternational9 = 0x8F,
    ATPortConfigItemCodeKeyboardLANG1 = 0x90,
    ATPortConfigItemCodeKeyboardLANG2 = 0x91,
    ATPortConfigItemCodeKeyboardLANG3 = 0x92,
    ATPortConfigItemCodeKeyboardLANG4 = 0x93,
    ATPortConfigItemCodeKeyboardLANG5 = 0x94,
    ATPortConfigItemCodeKeyboardLANG6 = 0x95,
    ATPortConfigItemCodeKeyboardLANG7 = 0x96,
    ATPortConfigItemCodeKeyboardLANG8 = 0x97,
    ATPortConfigItemCodeKeyboardLANG9 = 0x98,
    ATPortConfigItemCodeKeyboardAlternateErase = 0x99,
    ATPortConfigItemCodeKeyboardSysReqAttention = 0x9A,
    ATPortConfigItemCodeKeyboardCancel = 0x9B,
    ATPortConfigItemCodeKeyboardClear = 0x9C,
    ATPortConfigItemCodeKeyboardPrior = 0x9D,
    ATPortConfigItemCodeKeyboardReturn = 0x9E,
    ATPortConfigItemCodeKeyboardSeparator = 0x9F,
    ATPortConfigItemCodeKeyboardOut = 0xA0,
    ATPortConfigItemCodeKeyboardOper = 0xA1,
    ATPortConfigItemCodeKeyboardClearAgain = 0xA2,
    ATPortConfigItemCodeKeyboardCrSelProps = 0xA3,
    ATPortConfigItemCodeKeyboardExSel = 0xA4,
    ATPortConfigItemCodeKeyboardLeftControl = 0xE0,
    ATPortConfigItemCodeKeyboardLeftShift = 0xE1,
    ATPortConfigItemCodeKeyboardLeftAlt = 0xE2,
    ATPortConfigItemCodeKeyboardLeftGUI = 0xE3,
    ATPortConfigItemCodeKeyboardRightControl = 0xE4,
    ATPortConfigItemCodeKeyboardRightShift = 0xE5,
    ATPortConfigItemCodeKeyboardRightAlt = 0xE6,
    ATPortConfigItemCodeKeyboardRightGUI = 0xE7,
    ATPortConfigItemCodeKeyboardMinimum = ATPortConfigItemCodeKeyboardErrorRollOver,
    ATPortConfigItemCodeKeyboardMaximum = ATPortConfigItemCodeKeyboardRightGUI
};

typedef NS_ENUM(ATPortConfigItemCode, ATPortConfigItemCodeConsumer) {
    ATPortConfigItemCodeConsumerPower = 0x0030,
    ATPortConfigItemCodeConsumerReset = 0x0031,
    ATPortConfigItemCodeConsumerSleep = 0x0032,
    ATPortConfigItemCodeConsumerSleepAfter = 0x0033,
    ATPortConfigItemCodeConsumerSleepMode = 0x0034,
    ATPortConfigItemCodeConsumerMenu = 0x0040,
    ATPortConfigItemCodeConsumerMenuPick = 0x0041,
    ATPortConfigItemCodeConsumerMenuUp = 0x0042,
    ATPortConfigItemCodeConsumerMenuDown = 0x0043,
    ATPortConfigItemCodeConsumerMenuLeft = 0x0044,
    ATPortConfigItemCodeConsumerMenuRight = 0x0045,
    ATPortConfigItemCodeConsumerMenuEscape = 0x0046,
    ATPortConfigItemCodeConsumerMenuValueIncrease = 0x0047,
    ATPortConfigItemCodeConsumerMenuValueDecrease = 0x0048,
    ATPortConfigItemCodeConsumerAssignSelection = 0x0081,
    ATPortConfigItemCodeConsumerModeStep = 0x0082,
    ATPortConfigItemCodeConsumerRecallLast = 0x0083,
    ATPortConfigItemCodeConsumerEnterChannel = 0x0084,
    ATPortConfigItemCodeConsumerOrderMovie = 0x0085,
    ATPortConfigItemCodeConsumerMediaSelectComputer = 0x0088,
    ATPortConfigItemCodeConsumerMediaSelectTV = 0x0089,
    ATPortConfigItemCodeConsumerMediaSelectWWW = 0x008a,
    ATPortConfigItemCodeConsumerMediaSelectDVD = 0x008b,
    ATPortConfigItemCodeConsumerMediaSelectTelephone = 0x008c,
    ATPortConfigItemCodeConsumerMediaSelectProgramGuide = 0x008d,
    ATPortConfigItemCodeConsumerMediaSelectVideoPhone = 0x008e,
    ATPortConfigItemCodeConsumerMediaSelectGames = 0x008f,
    ATPortConfigItemCodeConsumerMediaSelectMessages = 0x0090,
    ATPortConfigItemCodeConsumerMediaSelectCD = 0x0091,
    ATPortConfigItemCodeConsumerMediaSelectVCR = 0x0092,
    ATPortConfigItemCodeConsumerMediaSelectTuner = 0x0093,
    ATPortConfigItemCodeConsumerQuit = 0x0094,
    ATPortConfigItemCodeConsumerHelp = 0x0095,
    ATPortConfigItemCodeConsumerMediaSelectTape = 0x0096,
    ATPortConfigItemCodeConsumerMediaSelectCable = 0x0097,
    ATPortConfigItemCodeConsumerMediaSelectSatellite = 0x0098,
    ATPortConfigItemCodeConsumerMediaSelectSecurity = 0x0099,
    ATPortConfigItemCodeConsumerMediaSelectHome = 0x009a,
    ATPortConfigItemCodeConsumerChannelIncrement = 0x009c,
    ATPortConfigItemCodeConsumerChannelDecrement = 0x009d,
    ATPortConfigItemCodeConsumerMediaSelectSAP = 0x009e,
    ATPortConfigItemCodeConsumerVCRPlus = 0x00a0,
    ATPortConfigItemCodeConsumerOnce = 0x00a1,
    ATPortConfigItemCodeConsumerDaily = 0x00a2,
    ATPortConfigItemCodeConsumerWeekly = 0x00a3,
    ATPortConfigItemCodeConsumerMonthly = 0x00a4,
    ATPortConfigItemCodeConsumerPlay = 0x00b0,
    ATPortConfigItemCodeConsumerPause = 0x00b1,
    ATPortConfigItemCodeConsumerRecord = 0x00b2,
    ATPortConfigItemCodeConsumerFastForward = 0x00b3,
    ATPortConfigItemCodeConsumerRewind = 0x00b4,
    ATPortConfigItemCodeConsumerScanNextTrack = 0x00b5,
    ATPortConfigItemCodeConsumerScanPreviousTrack = 0x00b6,
    ATPortConfigItemCodeConsumerStop = 0x00b7,
    ATPortConfigItemCodeConsumerEject = 0x00b8,
    ATPortConfigItemCodeConsumerRandomPlay = 0x00b9,
    ATPortConfigItemCodeConsumerSelectDisc = 0x00ba,
    ATPortConfigItemCodeConsumerEnterDisc = 0x00bb,
    ATPortConfigItemCodeConsumerRepeat = 0x00bc,
    ATPortConfigItemCodeConsumerTrackNormal = 0x00be,
    ATPortConfigItemCodeConsumerFrameForward = 0x00c0,
    ATPortConfigItemCodeConsumerFrameBack = 0x00c1,
    ATPortConfigItemCodeConsumerMark = 0x00c2,
    ATPortConfigItemCodeConsumerClearMark = 0x00c3,
    ATPortConfigItemCodeConsumerRepeatFromMark = 0x00c4,
    ATPortConfigItemCodeConsumerReturnToMark = 0x00c5,
    ATPortConfigItemCodeConsumerSearchMarkForward = 0x00c6,
    ATPortConfigItemCodeConsumerSearchMarkBackwards = 0x00c7,
    ATPortConfigItemCodeConsumerCounterReset = 0x00c8,
    ATPortConfigItemCodeConsumerShowCounter = 0x00c9,
    ATPortConfigItemCodeConsumerTrackingIncrement = 0x00ca,
    ATPortConfigItemCodeConsumerTrackingDecrement = 0x00cb,
    ATPortConfigItemCodeConsumerStopEject = 0x00cc,
    ATPortConfigItemCodeConsumerPlayPause = 0x00cd,
    ATPortConfigItemCodeConsumerPlaySkip = 0x00ce,
    ATPortConfigItemCodeConsumerMute = 0x00e2,
    ATPortConfigItemCodeConsumerBassBoost = 0x00e5,
    ATPortConfigItemCodeConsumerSurroundMode = 0x00e6,
    ATPortConfigItemCodeConsumerLoudness = 0x00e7,
    ATPortConfigItemCodeConsumerMPX = 0x00e8,
    ATPortConfigItemCodeConsumerVolumeIncrement = 0x00e9,
    ATPortConfigItemCodeConsumerVolumeDecrement = 0x00ea,
    ATPortConfigItemCodeConsumerALLaunchButtonConfigTool = 0x0181,
    ATPortConfigItemCodeConsumerALProgrammableButtonConfig = 0x0182,
    ATPortConfigItemCodeConsumerALConsumerControlConfig = 0x0183,
    ATPortConfigItemCodeConsumerALWordProcessor = 0x0184,
    ATPortConfigItemCodeConsumerALTextEditor = 0x0185,
    ATPortConfigItemCodeConsumerALSpreadsheet = 0x0186,
    ATPortConfigItemCodeConsumerALGraphicsEditor = 0x0187,
    ATPortConfigItemCodeConsumerALPresentationApp = 0x0188,
    ATPortConfigItemCodeConsumerALDatabaseApp = 0x0189,
    ATPortConfigItemCodeConsumerALEmailReader = 0x018a,
    ATPortConfigItemCodeConsumerALNewsreader = 0x018b,
    ATPortConfigItemCodeConsumerALVoicemail = 0x018c,
    ATPortConfigItemCodeConsumerALContactsAddressBook = 0x018d,
    ATPortConfigItemCodeConsumerALCalendarSchedule = 0x018e,
    ATPortConfigItemCodeConsumerALTaskProjectManager = 0x018f,
    ATPortConfigItemCodeConsumerALLogJournalTimecard = 0x0190,
    ATPortConfigItemCodeConsumerALCheckbookFinance = 0x0191,
    ATPortConfigItemCodeConsumerALCalculator = 0x0192,
    ATPortConfigItemCodeConsumerALAVCapturePlayback = 0x0193,
    ATPortConfigItemCodeConsumerALLocalMachineBrowser = 0x0194,
    ATPortConfigItemCodeConsumerALLANWANBrowser = 0x0195,
    ATPortConfigItemCodeConsumerALInternetBrowser = 0x0196,
    ATPortConfigItemCodeConsumerALRemoteNetworkingISPConnect = 0x0197,
    ATPortConfigItemCodeConsumerALNetworkConference = 0x0198,
    ATPortConfigItemCodeConsumerALNetworkChat = 0x0199,
    ATPortConfigItemCodeConsumerALTelephonyDialer = 0x019a,
    ATPortConfigItemCodeConsumerALLogon = 0x019b,
    ATPortConfigItemCodeConsumerALLogoff = 0x019c,
    ATPortConfigItemCodeConsumerALLogonLogoff = 0x019d,
    ATPortConfigItemCodeConsumerALTerminalLockScreensaver = 0x019e,
    ATPortConfigItemCodeConsumerALControlPanel = 0x019f,
    ATPortConfigItemCodeConsumerALCommandLineProcessorRun = 0x01a0,
    ATPortConfigItemCodeConsumerALProcessTaskManager = 0x01a1,
    ATPortConfigItemCodeConsumerALSelectTaskApplication = 0x01a2,
    ATPortConfigItemCodeConsumerALNextTaskApplication = 0x01a3,
    ATPortConfigItemCodeConsumerALPreviousTaskApplication = 0x01a4,
    ATPortConfigItemCodeConsumerALPreemptiveHaltTaskApp = 0x01a5,
    ATPortConfigItemCodeConsumerALIntegratedHelpCenter = 0x01a6,
    ATPortConfigItemCodeConsumerALDocuments = 0x01a7,
    ATPortConfigItemCodeConsumerALThesaurus = 0x01a8,
    ATPortConfigItemCodeConsumerALDictionary = 0x01a9,
    ATPortConfigItemCodeConsumerALDesktop = 0x01aa,
    ATPortConfigItemCodeConsumerALSpellCheck = 0x01ab,
    ATPortConfigItemCodeConsumerALGrammarCheck = 0x01ac,
    ATPortConfigItemCodeConsumerALWirelessStatus = 0x01ad,
    ATPortConfigItemCodeConsumerALKeyboardLayout = 0x01ae,
    ATPortConfigItemCodeConsumerALVirusProtection = 0x01af,
    ATPortConfigItemCodeConsumerALEncryption = 0x01b0,
    ATPortConfigItemCodeConsumerALScreenSaver = 0x01b1,
    ATPortConfigItemCodeConsumerALAlarms = 0x01b2,
    ATPortConfigItemCodeConsumerALClock = 0x01b3,
    ATPortConfigItemCodeConsumerALFileBrowser = 0x01b4,
    ATPortConfigItemCodeConsumerALPowerStatus = 0x01b5,
    ATPortConfigItemCodeConsumerALImageBrowser = 0x01b6,
    ATPortConfigItemCodeConsumerALAudioBrowser = 0x01b7,
    ATPortConfigItemCodeConsumerALMovieBrowser = 0x01b8,
    ATPortConfigItemCodeConsumerALDigitalRightsManager = 0x01b9,
    ATPortConfigItemCodeConsumerALDigitalWallet = 0x01ba,
    ATPortConfigItemCodeConsumerALInstantMessaging = 0x01bc,
    ATPortConfigItemCodeConsumerALOEMFeaturesTipsBrowser = 0x01bd,
    ATPortConfigItemCodeConsumerALOEMHelp = 0x01be,
    ATPortConfigItemCodeConsumerALOnlineCommunity = 0x01bf,
    ATPortConfigItemCodeConsumerALEntertainmentContentBrowser = 0x01c0,
    ATPortConfigItemCodeConsumerALOnlineShoppingBrowser = 0x01c1,
    ATPortConfigItemCodeConsumerALSmartCardInformationHelp = 0x01c2,
    ATPortConfigItemCodeConsumerALMarketFinanceBrowser = 0x01c3,
    ATPortConfigItemCodeConsumerALCustomizedCorpNewsBrowser = 0x01c4,
    ATPortConfigItemCodeConsumerALOnlineActivityBrowser = 0x01c5,
    ATPortConfigItemCodeConsumerALResearchSearchBrowser = 0x01c6,
    ATPortConfigItemCodeConsumerALAudioPlayer = 0x01c7,
    ATPortConfigItemCodeConsumerACNew = 0x0201,
    ATPortConfigItemCodeConsumerACOpen = 0x0202,
    ATPortConfigItemCodeConsumerACClose = 0x0203,
    ATPortConfigItemCodeConsumerACExit = 0x0204,
    ATPortConfigItemCodeConsumerACMaximize = 0x0205,
    ATPortConfigItemCodeConsumerACMinimize = 0x0206,
    ATPortConfigItemCodeConsumerACSave = 0x0207,
    ATPortConfigItemCodeConsumerACPrint = 0x0208,
    ATPortConfigItemCodeConsumerACProperties = 0x0209,
    ATPortConfigItemCodeConsumerACUndo = 0x021a,
    ATPortConfigItemCodeConsumerACCopy = 0x021b,
    ATPortConfigItemCodeConsumerACCut = 0x021c,
    ATPortConfigItemCodeConsumerACPaste = 0x021d,
    ATPortConfigItemCodeConsumerACSelectAll = 0x021e,
    ATPortConfigItemCodeConsumerACFind = 0x021f,
    ATPortConfigItemCodeConsumerACFindAndReplace = 0x0220,
    ATPortConfigItemCodeConsumerACSearch = 0x0221,
    ATPortConfigItemCodeConsumerACGoTo = 0x0222,
    ATPortConfigItemCodeConsumerACHome = 0x0223,
    ATPortConfigItemCodeConsumerACBack = 0x0224,
    ATPortConfigItemCodeConsumerACForward = 0x0225,
    ATPortConfigItemCodeConsumerACStop = 0x0226,
    ATPortConfigItemCodeConsumerACRefresh = 0x0227,
    ATPortConfigItemCodeConsumerACPreviousLink = 0x0228,
    ATPortConfigItemCodeConsumerACNextLink = 0x0229,
    ATPortConfigItemCodeConsumerACBookmarks = 0x022a,
    ATPortConfigItemCodeConsumerACHistory = 0x022b,
    ATPortConfigItemCodeConsumerACSubscriptions = 0x022c,
    ATPortConfigItemCodeConsumerACZoomIn = 0x022d,
    ATPortConfigItemCodeConsumerACZoomOut = 0x022e,
    ATPortConfigItemCodeConsumerACZoom = 0x022f,
    ATPortConfigItemCodeConsumerACFullScreenView = 0x0230,
    ATPortConfigItemCodeConsumerACNormalView = 0x0231,
    ATPortConfigItemCodeConsumerACViewToggle = 0x0232,
    ATPortConfigItemCodeConsumerACScrollUp = 0x0233,
    ATPortConfigItemCodeConsumerACScrollDown = 0x0234,
    ATPortConfigItemCodeConsumerACPanLeft = 0x0236,
    ATPortConfigItemCodeConsumerACPanRight = 0x0237,
    ATPortConfigItemCodeConsumerACNewWindow = 0x0239,
    ATPortConfigItemCodeConsumerACTileHorizontally = 0x023a,
    ATPortConfigItemCodeConsumerACTileVertically = 0x023b,
    ATPortConfigItemCodeConsumerACFormat = 0x023c,
    ATPortConfigItemCodeConsumerACEdit = 0x023d,
    ATPortConfigItemCodeConsumerACBold = 0x023e,
    ATPortConfigItemCodeConsumerACItalics = 0x023f,
    ATPortConfigItemCodeConsumerACUnderline = 0x0240,
    ATPortConfigItemCodeConsumerACStrikethrough = 0x0241,
    ATPortConfigItemCodeConsumerACSubscript = 0x0242,
    ATPortConfigItemCodeConsumerACSuperscript = 0x0243,
    ATPortConfigItemCodeConsumerACAllCaps = 0x0244,
    ATPortConfigItemCodeConsumerACRotate = 0x0245,
    ATPortConfigItemCodeConsumerACResize = 0x0246,
    ATPortConfigItemCodeConsumerACFliphorizontal = 0x0247,
    ATPortConfigItemCodeConsumerACFlipVertical = 0x0248,
    ATPortConfigItemCodeConsumerACMirrorHorizontal = 0x0249,
    ATPortConfigItemCodeConsumerACMirrorVertical = 0x024a,
    ATPortConfigItemCodeConsumerACFontSelect = 0x024b,
    ATPortConfigItemCodeConsumerACFontColor = 0x024c,
    ATPortConfigItemCodeConsumerACFontSize = 0x024d,
    ATPortConfigItemCodeConsumerACJustifyLeft = 0x024e,
    ATPortConfigItemCodeConsumerACJustifyCenterH = 0x024f,
    ATPortConfigItemCodeConsumerACJustifyRight = 0x0250,
    ATPortConfigItemCodeConsumerACJustifyBlockH = 0x0251,
    ATPortConfigItemCodeConsumerACJustifyTop = 0x0252,
    ATPortConfigItemCodeConsumerACJustifyCenterV = 0x0253,
    ATPortConfigItemCodeConsumerACJustifyBottom = 0x0254,
    ATPortConfigItemCodeConsumerACJustifyBlockV = 0x0255,
    ATPortConfigItemCodeConsumerACIndentDecrease = 0x0256,
    ATPortConfigItemCodeConsumerACIndentIncrease = 0x0257,
    ATPortConfigItemCodeConsumerACNumberedList = 0x0258,
    ATPortConfigItemCodeConsumerACRestartNumbering = 0x0259,
    ATPortConfigItemCodeConsumerACBulletedList = 0x025a,
    ATPortConfigItemCodeConsumerACPromote = 0x025b,
    ATPortConfigItemCodeConsumerACDemote = 0x025c,
    ATPortConfigItemCodeConsumerACYes = 0x025d,
    ATPortConfigItemCodeConsumerACNo = 0x025e,
    ATPortConfigItemCodeConsumerACCancel = 0x025f,
    ATPortConfigItemCodeConsumerACCatalog = 0x0260,
    ATPortConfigItemCodeConsumerACBuyCheckout = 0x0261,
    ATPortConfigItemCodeConsumerACAddtoCart = 0x0262,
    ATPortConfigItemCodeConsumerACExpand = 0x0263,
    ATPortConfigItemCodeConsumerACExpandAll = 0x0264,
    ATPortConfigItemCodeConsumerACCollapse = 0x0265,
    ATPortConfigItemCodeConsumerACCollapseAll = 0x0266,
    ATPortConfigItemCodeConsumerACPrintPreview = 0x0267,
    ATPortConfigItemCodeConsumerACPasteSpecial = 0x0268,
    ATPortConfigItemCodeConsumerACInsertMode = 0x0269,
    ATPortConfigItemCodeConsumerACDelete = 0x026a,
    ATPortConfigItemCodeConsumerACLock = 0x026b,
    ATPortConfigItemCodeConsumerACUnlock = 0x026c,
    ATPortConfigItemCodeConsumerACProtect = 0x026d,
    ATPortConfigItemCodeConsumerACUnprotect = 0x026e,
    ATPortConfigItemCodeConsumerACAttachComment = 0x026f,
    ATPortConfigItemCodeConsumerACDeleteComment = 0x0270,
    ATPortConfigItemCodeConsumerACViewComment = 0x0271,
    ATPortConfigItemCodeConsumerACSelectWord = 0x0272,
    ATPortConfigItemCodeConsumerACSelectSentence = 0x0273,
    ATPortConfigItemCodeConsumerACSelectParagraph = 0x0274,
    ATPortConfigItemCodeConsumerACSelectColumn = 0x0275,
    ATPortConfigItemCodeConsumerACSelectRow = 0x0276,
    ATPortConfigItemCodeConsumerACSelectTable = 0x0277,
    ATPortConfigItemCodeConsumerACSelectObject = 0x0278,
    ATPortConfigItemCodeConsumerACRedoRepeat = 0x0279,
    ATPortConfigItemCodeConsumerACSort = 0x027a,
    ATPortConfigItemCodeConsumerACSortAscending = 0x027b,
    ATPortConfigItemCodeConsumerACSortDescending = 0x027c,
    ATPortConfigItemCodeConsumerACFilter = 0x027d,
    ATPortConfigItemCodeConsumerACSetClock = 0x027e,
    ATPortConfigItemCodeConsumerACViewClock = 0x027f,
    ATPortConfigItemCodeConsumerACSelectTimeZone = 0x0280,
    ATPortConfigItemCodeConsumerACEditTimeZones = 0x0281,
    ATPortConfigItemCodeConsumerACSetAlarm = 0x0282,
    ATPortConfigItemCodeConsumerACClearAlarm = 0x0283,
    ATPortConfigItemCodeConsumerACSnoozeAlarm = 0x0284,
    ATPortConfigItemCodeConsumerACResetAlarm = 0x0285,
    ATPortConfigItemCodeConsumerACSynchronize = 0x0286,
    ATPortConfigItemCodeConsumerACSendReceive = 0x0287,
    ATPortConfigItemCodeConsumerACSendTo = 0x0288,
    ATPortConfigItemCodeConsumerACReply = 0x0289,
    ATPortConfigItemCodeConsumerACReplyAll = 0x028a,
    ATPortConfigItemCodeConsumerACForwardMsg = 0x028b,
    ATPortConfigItemCodeConsumerACSend = 0x028c,
    ATPortConfigItemCodeConsumerACAttachFile = 0x028d,
    ATPortConfigItemCodeConsumerACUpload = 0x028e,
    ATPortConfigItemCodeConsumerACDownloadSaveTargetAs = 0x028f,
    ATPortConfigItemCodeConsumerACSetBorders = 0x0290,
    ATPortConfigItemCodeConsumerACInsertRow = 0x0291,
    ATPortConfigItemCodeConsumerACInsertColumn = 0x0292,
    ATPortConfigItemCodeConsumerACInsertFile = 0x0293,
    ATPortConfigItemCodeConsumerACInsertPicture = 0x0294,
    ATPortConfigItemCodeConsumerACInsertObject = 0x0295,
    ATPortConfigItemCodeConsumerACInsertSymbol = 0x0296,
    ATPortConfigItemCodeConsumerACSaveAndClose = 0x0297,
    ATPortConfigItemCodeConsumerACRename = 0x0298,
    ATPortConfigItemCodeConsumerACMerge = 0x0299,
    ATPortConfigItemCodeConsumerACSplit = 0x029a,
    ATPortConfigItemCodeConsumerACDistributeHorizontally = 0x029b,
    ATPortConfigItemCodeConsumerMinimum = ATPortConfigItemCodeConsumerPower,
    ATPortConfigItemCodeConsumerMaximum = ATPortConfigItemCodeConsumerACDistributeHorizontally,
};

typedef NS_ENUM(ATPortConfigItemCode, ATPortConfigItemCodeMouse) {
    ATPortConfigItemCodeMouseLeft = 1 << 0,
    ATPortConfigItemCodeMouseRight = 1 << 1,
    ATPortConfigItemCodeMouseMiddle = 1 << 2,
    ATPortConfigItemCodeMouseMaskAll = 0b111
};

NSString * _Nullable DescriptionForATPortConfigItemCode(ATPortConfigItemType type, ATPortConfigItemCode code);

NSString * _Nullable DescriptionForATPortConfigItemModifiers(ATPortConfigItemModifier modifiers);

NSString * _Nullable CompactDescriptionForATPortConfigItemCode(ATPortConfigItemType type, ATPortConfigItemCode code);

NSString * _Nullable CompactDescriptionForATPortConfigItemModifiers(ATPortConfigItemModifier modifiers);
