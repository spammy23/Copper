package me.ezeh.copper.i18n

object LangStorage {
    private val DEFAULT_LOCALE = Locale.ENGLISH_GB
    private fun getFormatString(langKey: CopperLangKey, locale: Locale): String {
        return langKey.defaultString // TODO: other languages
    }

    fun getFormatString(langKey: CopperLangKey) = getFormatString(langKey, DEFAULT_LOCALE)
}