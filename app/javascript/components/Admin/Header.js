import React from "react";

function Header() {
  return (
    <header className="fixed w-full flex flex-row flex-nowrap gap-x-4 border-b-2 p-3">
      <div id="logo" className="text-lg font-bold tracking-wider">Shop App</div>
      <ul className="flex flex-row flex-nowrap gap-x-2 items-center">
        <li><a href="/admin">Dashboard</a></li>
        <li><a href="/admin/products">Products</a></li>
      </ul>
    </header>
  );
}

export default Header;
