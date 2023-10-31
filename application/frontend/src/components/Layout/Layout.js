import React from 'react';
import './Layout.css'; // Make sure to import your CSS file

const Layout = () => {
  return (
    <div className="layout-container">
      <header className="navbar">
        <div className="logo">Your Logo</div>
        <div className="login">Login</div>
      </header>
      <aside className="sidebar">
        <ul className="list">
          <li>List Item 1</li>
          <li>List Item 2</li>
          <li>List Item 3</li>
          {/* Add more list items as needed */}
        </ul>
      </aside>
      <main className="main-content">
        {/* Your main content goes here */}
      </main>
    </div>
  );
}

export default Layout;
