import React, { useEffect } from "react";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";

function Header() {
  const [t, i18n] = useTranslation();
  useEffect(() => {
    return;
  }, [i18n.language]);

  return (
    <header className="flex flex-row flex-nowrap gap-x-4 border-b-2 p-3 mb-3">
      <div id="logo" className="text-lg font-bold tracking-wider">Shop App</div>
      <ul className="flex flex-row flex-nowrap gap-x-2 items-center">
        <li><Link to="/admin">{t("admin.header.dashboard")}</Link></li>
        <li><Link to="/admin/products">{t("admin.header.products")}</Link></li>
        <li><Link to="/admin/admin_users">{t("admin.header.admin_users")}</Link></li>
      </ul>
    </header>
  );
}

export default Header;
