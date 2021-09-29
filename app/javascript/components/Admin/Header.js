import React from "react";
import { Link } from "react-router-dom";

function Header() {
  return (
    <header className="flex flex-row flex-nowrap gap-x-4 border-b-2 p-3 mb-3">
      <div id="logo" className="text-lg font-bold tracking-wider">Shop App</div>
      <ul className="flex flex-row flex-nowrap gap-x-2 items-center">
        <li><Link to="/admin">Dashboard</Link></li>
        <li><Link to="/admin/products">Products</Link></li>
        <li><Link to="/admin/admin_users">Admins</Link></li>
      </ul>
    </header>
  );
}

export default Header;
