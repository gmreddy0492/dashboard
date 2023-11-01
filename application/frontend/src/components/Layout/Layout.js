import React from 'react';
import { Container, Row, Col } from 'react-bootstrap';
import Header from './header';
import Sidebar from './sidebar';
import Footer from './footer';

const Layout = () => {
  return (
    <Container fluid>
      <Row>
        <Col>
          <Header />
        </Col>
      </Row>
      <Row>
        <Col xs={3}>
          <Sidebar />
        </Col>
        <Col xs={9}>
          {/* Body content goes here */}
        </Col>
      </Row>
      <Row>
        <Col>
          <Footer />
        </Col>
      </Row>
    </Container>
  );
};

export default Layout;
