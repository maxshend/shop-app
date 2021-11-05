import React, { useEffect, useState } from "react";
import { useTranslation } from "react-i18next";
import DialogMessage from "../../General/DialogMessage";
import InputError from "../../General/InputError";
import { useHistory } from "react-router-dom";

function AdminUserForm() {
  const history = useHistory();
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [inputErrors, setInputErrors] = useState({});
  const [t, i18n] = useTranslation();
  useEffect(() => {
    return;
  }, [i18n.language]);
  const [message, setMessage] = useState("");

  const createNewUser = (event) => {
    event.preventDefault();

    fetch(`/api/admin/admin_users`, {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ admin_user: { name: name, email: email } })
      }
    )
    .then(res => res.json())
    .then(
      (res) => {
        if (!res.success) {
          let errors = {}
          res.errors.forEach(err => errors[err.key] = err.messages.join(", "));

          setInputErrors(errors)
        } else {
          history.push({ pathname: "/admin/admin_users", state: { textMessage: t("success") } });
        }
      },
      (err) => {
        setMessage(err.toString());
      }
    );
  };

  return (
    <div className="flex justify-center">
      <DialogMessage text={message} onClose={() => setMessage("")}/>
      <form id="adminUserForm" className="flex flex-col gap-y-2 md:w-3/6 lg:w-2/6" onSubmit={createNewUser}>
      <label htmlFor="adminUserEmail">{t("admin.admin_users.email")}</label>
        <InputError text={inputErrors["email"]}/>
        <input
          className="border-2"
          type="text"
          name="email"
          id="adminUserEmail"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />

        <label htmlFor="adminUserName">{t("admin.admin_users.name")}</label>
        <InputError text={inputErrors["name"]}/>
        <input
          className="border-2"
          type="text"
          name="name"
          id="adminUserName"
          value={name}
          onChange={(e) => setName(e.target.value)}
        />
        <button className="button-add">{t("create")}</button>
      </form>
    </div>
  );
}

export default AdminUserForm;
