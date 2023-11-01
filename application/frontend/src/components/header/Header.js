import React from 'react';
import { Navbar, Nav, Image, Button } from 'react-bootstrap';

const Header = () => {
  return (
    <Navbar bg="light" expand="lg">
      <Navbar.Brand>
        <Image src="your-logo-image-url.png" alt="Logo" />
      </Navbar.Brand>
      <Navbar.Toggle aria-controls="basic-navbar-nav" />
      <Navbar.Collapse id="basic-navbar-nav">
        <Nav className="ml-auto">
          <Button variant="primary">Login/Sign Up</Button>
        </Nav>
      </Navbar.Collapse>
    </Navbar>
  );
};

export default Header;
