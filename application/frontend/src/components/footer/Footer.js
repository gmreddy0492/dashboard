import React from 'react';
import { Container, Row, Col } from 'react-bootstrap';

const Footer = () => {
  return (
    <Container fluid>
      <Row>
        <Col>
          <p>&copy; Your Copyright Text</p>
        </Col>
      </Row>
    </Container>
  );
};

export default Footer;
