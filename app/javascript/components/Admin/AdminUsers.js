import React from "react";
import { useTranslation } from "react-i18next";

function AdminUsers() {
  const [t, i18n] = useTranslation();

  return (
    <table id="adminUsersTable" className="w-full border-collapse border-2 table-auto">
      <thead className="bg-gray-200">
        <tr className="text-center">
          <th>{t("admin.admin_users.id")}</th>
          <th>{t("admin.admin_users.name")}</th>
          <th>{t("admin.admin_users.email")}</th>
          <th>{t("admin.admin_users.created_at")}</th>
          <th></th>
        </tr>
      </thead>
      <tbody></tbody>
    </table>
  );
}

export default AdminUsers;
