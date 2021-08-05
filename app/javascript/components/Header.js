import React, { useEffect, useState } from "react";

import { useTranslation } from 'react-i18next';
import { LANGUAGES } from '../packs/i18n';

function Header() {
  const [_, i18n] = useTranslation();
  const [language, setLanguage] = useState(i18n.language);
  useEffect(() => {
    i18n.changeLanguage(language);
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
