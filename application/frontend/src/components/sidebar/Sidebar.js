import React from 'react';
import { Nav, Accordion } from 'react-bootstrap';

const Sidebar = () => {
  return (
    <Accordion defaultActiveKey="0">
      <Nav defaultActiveKey="/server-details">
        <Accordion.Item eventKey="0">
          <Accordion.Header>Server Details</Accordion.Header>
          <Accordion.Body>
            <Nav.Link href="/server-details">Server Details</Nav.Link>
          </Accordion.Body>
        </Accordion.Item>
        <Accordion.Item eventKey="1">
          <Accordion.Header>Applications</Accordion.Header>
          <Accordion.Body>
            <Nav.Link href="/applications">Applications</Nav.Link>
          </Accordion.Body>
        </Accordion.Item>
      </Nav>
    </Accordion>
  );
};

export default Sidebar;
