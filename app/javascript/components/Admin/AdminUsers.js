import React, { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import DialogMessage from "../General/DialogMessage";

function AdminUsers() {
  const [t, i18n] = useTranslation();
  const [users, setUsers] = useState([]);
  useEffect(() => {
    fetchUsers();

    return;
  }, [i18n.language]);
  const [error, setError] = useState(null);
  const [message, setMessage] = useState("");
  
  if (error) {
    return UsersError(t);
  }

  const fetchUsers = () => {
    fetch(`/api/admin/admin_users?locale=${i18n.language}`)
    .then(res => res.json())
    .then(
      (res) => {
        setUsers(res.admin_users);
      },
      (err) => {
        setError(err)
      }
    );
  };

  const handleDestroyUser = (e, id) => {
    e.preventDefault();

    fetch(`/api/admin/admin_users/${id}`, { method: 'DELETE' })
    .then(res => res.json())
    .then(
      (res) => {
        if (res.success) {
          setUsers(users.filter((u) => u.id !== id));
        }
      },
      (err) => {
        setMessage(err.toString());
      }
    )
  };

  const usersList = users.map(user => {
    return (
      <tr key={user.id} className="adminUserRow p-2 text-center">
        <td className="border-2">{user.id}</td>
        <td className="border-2">{user.name}</td>
        <td className="border-2">{user.email}</td>
        <td className="border-2">{user.created_at}</td>
        <td className="border-2 text-blue-500">
        <a className="deleteAdminUserBtn" href="" onClick={(e) => handleDestroyUser(e, user.id)}>{t("delete")}</a>
        </td>
      </tr>
    );
  });

  return (
    <div>
      <DialogMessage text={message} onClose={() => setMessage("")}/>
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
        <tbody>{usersList}</tbody>
      </table>
    </div>
  );
}

function UsersError(t) {
  return (
    <div className="text-center">
      <span className="font-bold text-red-400">{t("errors.admin_users.load")}</span>
    </div>
  );
}

export default AdminUsers;
