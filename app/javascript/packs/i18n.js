import i18n from 'i18next';
import { initReactI18next } from "react-i18next";

import Backend from 'i18next-http-backend';

export const LANGUAGES = ['en', 'ua', 'ru'];

i18n.use(Backend).use(initReactI18next).init({
  fallbackLng: LANGUAGES[0],
  supportedLngs: LANGUAGES,
  debug: false,
  interpolation: {
    escapeValue: false
  }
});

export default i18n;
