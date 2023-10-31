import React from 'react';
import { Navbar, Nav, NavDropdown, Container, Row, Col } from 'react-bootstrap';


const Layout = () => {
  return (
    <div>
      {/* Navbar with Logo and Login */}
      <Navbar bg="dark" variant="dark">
        <Container>
          <Navbar.Brand href="#home">Your Logo</Navbar.Brand>
          <Nav className="ml-auto">
            <Nav.Link href="#login">Login</Nav.Link>
          </Nav>
        </Container>
      </Navbar>

      {/* Sidecar with Applications Dropdown */}
      <Container>
        <Row>
          <Col md={2}>
            <Nav className="flex-column">
              <NavDropdown title="Applications" id="basic-nav-dropdown">
                <NavDropdown.Item href="#action/1">Application 1</NavDropdown.Item>
                <NavDropdown.Item href="#action/2">Application 2</NavDropdown.Item>
                <NavDropdown.Item href="#action/3">Application 3</NavDropdown.Item>
              </NavDropdown>
            </Nav>
          </Col>

          {/* Main Body */}
          <Col md={10}>
            {/* Your main content goes here */}
          </Col>
        </Row>
      </Container>
    </div>
  );
};

export default Layout;
