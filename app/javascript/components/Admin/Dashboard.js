import React, { Suspense } from "react";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";

import Spinner from "../Spinner";

import Header from "./Header";
import Products from "./Products";
import AdminUsers from "./AdminUser/AdminUsers";
import AdminUserForm from "./AdminUser/AdminUserForm";

function Dashboard() {
  return (
    <Router>
      <Suspense fallback={<Spinner />}>
        <Header />
        <div className="p-3">
          <Switch>
            <Route exact path="/admin">
              <Products />
            </Route>
            <Route exact path="/admin/admin_users">
              <AdminUsers />
            </Route>
            <Route exact path="/admin/products">
              <Products />
            </Route>
            <Route exact path="/admin/admin_users/new">
              <AdminUserForm />
            </Route>
          </Switch>
        </div>
      </Suspense>
    </Router>
  );
}

export default Dashboard;
