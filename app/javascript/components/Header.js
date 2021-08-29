import React, { useEffect, useState, useRef } from "react";

import { useTranslation } from "react-i18next";
import { LANGUAGES } from '../packs/i18n';

function Header() {
  const isInitialMount = useRef(true);
  const [_, i18n] = useTranslation();
  const [languages, setLanguages] = useState([]);
  useEffect(() => {
    fetchLanguages(setLanguages, setError);
  }, []);
  const [language, setLanguage] = useState(i18n.language);
  useEffect(() => {
    if (isInitialMount.current) {
      isInitialMount.current = false;
    } else {
      i18n.changeLanguage(language);
    }

    return;
  }, [language]);
  const [error, setError] = useState(null);

  const changeHandler = (event) => {
    event.preventDefault();
    setLanguage(event.target.value);
  };

  var languageSelect = null;
  if (!error) {
    const languageOptions = languages.map((language) => {
      return <option key={language} value={language}>{language}</option>
    });

    languageSelect = (
      <select value={language} onChange={changeHandler}>
        {languageOptions}
      </select>
    );
  }

  return (
    <div className="flex justify-end">
      {languageSelect}
    </div>
  );
}

function fetchLanguages(setLanguages, setError) {
  fetch('/api/v1/locales')
  .then(res => res.json())
  .then(
    (res) => {
      setLanguages(res.locales);
    },
    (err) => {
      setError(err);
    }
  );
}

export default Header;
