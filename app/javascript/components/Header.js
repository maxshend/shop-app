import React, { useEffect, useState, useRef } from "react";

import { useTranslation } from "react-i18next";
import { LANGUAGES } from '../packs/i18n';

function Header() {
  const isInitialMount = useRef(true);
  const [_, i18n] = useTranslation();
  const [language, setLanguage] = useState(i18n.language);
  useEffect(() => {
    if (isInitialMount.current) {
      isInitialMount.current = false;
    } else {
      i18n.changeLanguage(language);
    }

    return;
  }, [language]);

  const changeHandler = (event) => {
    event.preventDefault();
    setLanguage(event.target.value);
  };
  const languageOptions = LANGUAGES.map((language) => {
    return <option key={language} value={language}>{language}</option>
  });

  return (
    <div className="flex justify-end">
      <select value={language} onChange={changeHandler}>
        {languageOptions}
      </select>
    </div>
  );
}

export default Header;
