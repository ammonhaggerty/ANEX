# Agent Negotiation & Exchange Protocol (ANEX) Draft

## **1. Introduction**

The **Agent Negotiation & Exchange Protocol (ANEX)** is a universal handshake and data exchange protocol designed for AI-powered Personal Agents (PAs). These agents act as proxies for their owners—individuals or entities—and are trained to make decisions on their behalf, sometimes through human-in-the-loop collaboration. The goal of ANEX is to enable any PA engaging with another PA to identify protocol compliance, establish terms, and define the scope for an exchange of data and/or value.

This specification leverages the **Foundation for Intelligent Physical Agents (FIPA)** standards as the underlying protocol to facilitate agent communication. By leveraging FIPA standards, the `ANEX` protocol can facilitate secure and efficient communication between Personal Agents. While this initial draft focuses on core features like handshake, negotiation, and data exchange, the design accommodates future enhancements in security, scalability, and functionality.

<img width="1481" alt="ANEX flows" src="https://github.com/user-attachments/assets/54399dd3-5769-410d-b29a-996d8cd8c236">

---

## **2. Objectives**

- **Standardization:** Utilize FIPA standards to provide a universal protocol for seamless PA communication.
- **Compliance Identification:** Enable PAs to recognize and verify protocol adherence in other agents.
- **Secure Communication:** Ensure data exchanges are secure, using lightweight security measures suitable for the MVP.
- **Negotiation Framework:** Implement structured methods for PAs to establish terms and scope before data or service exchange.
- **Interoperability:** Facilitate interactions between PAs developed in Node.js and Python.
- **Extensibility:** Design the protocol to accommodate future enhancements, such as advanced security features and identity validation.

---

## **3. Foundational Concepts**

### **3.1 Personal Agents (PAs)**

- **Definition:** Autonomous AI agents acting on behalf of their owners to perform tasks, make decisions, and interact with other agents or humans.
- **Capabilities:** Data exchange, negotiation, and service offering.

### **3.2 FIPA Agent Communication Language (ACL)**

- **Purpose:** A language for expressing messages between agents, including performatives that indicate the intended meaning of the message.
- **Key Components:**
    - **Performatives:** Indicators of message intent (e.g., `REQUEST`, `INFORM`, `PROPOSE`).
    - **Content:** The actual data or information being communicated.
    - **Ontology:** A shared vocabulary that agents use to interpret content.
    - **Protocol:** The sequence of messages exchanged to achieve a specific interaction.

### **3.3 Interaction Protocols**

- **Definition:** Standardized sequences for common interaction patterns, such as requesting actions, negotiating terms, and exchanging information.
- **Relevant Protocols for ANEX:**
    - **FIPA-Request Interaction Protocol:** For initiating requests.
    - **FIPA-Contract-Net Interaction Protocol:** For negotiation scenarios.
    - **FIPA-Subscribe Interaction Protocol:** For continuous updates or streaming data.

---

## **4. Protocol Specification**

### **4.1 Overview**

The ANEX protocol consists of the following key phases:

1. **Self-Identification and Protocol Compliance Declaration**
2. **Initiation of Engagement**
3. **Response Handling (Opt-in/Opt-out/Modify)**
4. **Negotiation of Terms**
5. **Data Exchange**
6. **Session Termination**

### **4.2 Message Structure**

- **Syntax:** Messages are structured according to the FIPA ACL specification.
- **Components:**
    - **Performative:** The action type (e.g., `REQUEST`, `INFORM`).
    - **Sender:** The agent initiating the message.
    - **Receiver:** The intended recipient agent.
    - **Content:** The message payload, typically encoded in JSON for ease of use.
    - **Language:** The language used to express the content (e.g., `JSON`).
    - **Ontology:** Reference to the shared vocabulary.
    - **Protocol:** The interaction protocol being used.

### **4.3 Handshake Process**

#### **Step 1: Self-Identification and Protocol Compliance Declaration**

- **Action:** The initiating agent (Agent A) sends a message to the receiving agent (Agent B), introducing itself and declaring ANEX compliance. Proposed compact compliance indicator: [PA*].
- **Message Example:**
	```
	{
	  "performative": "REQUEST",
	  "sender": "AgentA",
	  "receiver": "AgentB",
	  "content": {
	    "message": "Hi, I'm [Owner's Name]'s AI assistant [PA*]."
	  },
	  "language": "JSON",
	  "ontology": "ANEX-Ontology",
	  "protocol": "ANEX-Handshaking"
	}
	```

#### **Step 2: Initiation of Engagement**

- **Action:** Agent A sends an engagement request to Agent B.
- **Message Example:**
	```
 	{
	  "performative": "REQUEST",
	  "sender": "AgentA",
	  "receiver": "AgentB",
	  "content": {
	    "request": "Set up time for an in-person meeting. Ok to continue?"
	  },
	  "language": "JSON",
	  "ontology": "ANEX-Ontology",
	  "protocol": "ANEX-Handshaking"
	}
 	```

#### **Step 3: Response Handling by Receiving Agent**

- **Options for Agent B:**
    
    - **Agree to Proceed:** Sends an `AGREE` message.
    - **Refuse to Proceed:** Sends a `REFUSE` message.
    - **Request Modification:** Sends a `PROPOSE` message with modifications.
- **Message Examples:**
    
    - **Agree:**
	```
	{
	  "performative": "AGREE",
	  "sender": "AgentB",
	  "receiver": "AgentA",
	  "content": {
	    "response": "Proceeding with the meeting setup."
	  },
	  "language": "JSON",
	  "ontology": "ANEX-Ontology",
	  "protocol": "ANEX-Handshaking"
	}
	```
        
	- **Refuse:**
	```
	{
	  "performative": "REFUSE",
	  "sender": "AgentB",
	  "receiver": "AgentA",
	  "content": {
	    "response": "I do not engage with unknown agents."
	  },
	  "language": "JSON",
	  "ontology": "ANEX-Ontology",
	  "protocol": "ANEX-Handshaking"
	}
	```

	- **Propose Modification:**
	```
	{
	  "performative": "PROPOSE",
	  "sender": "AgentB",
	  "receiver": "AgentA",
	  "content": {
	    "modification": "Please provide your owner’s email for verification."
	  },
	  "language": "JSON",
	  "ontology": "ANEX-Ontology",
	  "protocol": "ANEX-Handshaking"
	}
	```
        
### **4.4 Negotiation of Terms**

- **Action:** Agents use the **FIPA-Contract-Net Interaction Protocol** to negotiate terms and scope of data exchange.
    
- **Negotiation Steps:**
    
    - **Call for Proposal (CFP):** Agent A issues a CFP to Agent B, outlining the request and terms.
    - **Proposal Submission:** Agent B responds with a proposal, which may accept, decline, or modify the terms.
    - **Evaluation:** Agent A evaluates the proposal and decides to accept or reject.
      
- **CFP Message Example:**
	```
 	{
	  "performative": "CFP",
	  "sender": "AgentA",
	  "receiver": "AgentB",
	  "content": {
	    "request": {
	      "identity": "unique-id",
	      "owner": "Ammon Haggerty",
	      "relation": "acquaintance (Joe Smith)",
	      "request_type": "calendar negotiation",
	      "access": ["name(m)", "email(m)", "schedule"],
	      "promise": ["no data retention(m)"]
	    }
	  },
	  "language": "JSON",
	  "ontology": "ANEX-Ontology",
	  "protocol": "FIPA-Contract-Net"
	}
 	```

- **Proposal Message Example:**
	```
 	{
	  "performative": "PROPOSE",
	  "sender": "AgentB",
	  "receiver": "AgentA",
	  "content": {
	    "response": {
	      "access": ["name", "schedule"],
	      "promise": ["no data retention"]
	    }
	  },
	  "language": "JSON",
	  "ontology": "ANEX-Ontology",
	  "protocol": "FIPA-Contract-Net"
	}
	```    

### **4.5 Data Exchange**

- **Action:** Upon agreement, agents proceed to exchange data using the **FIPA-Request Interaction Protocol**.
    
- **Communication Channel:** For the MVP, agents use secure WebSocket connections (`wss://`) to facilitate real-time, asynchronous communication.
    
- **Data Message Example:**
	```
 	{
	  "performative": "INFORM",
	  "sender": "AgentA",
	  "receiver": "AgentB",
	  "content": {
	    "meeting_times": ["2023-11-01T10:00:00Z", "2023-11-02T14:00:00Z"]
	  },
	  "language": "JSON",
	  "ontology": "ANEX-Ontology",
	  "protocol": "ANEX-Data-Exchange"
	}
 	```
    
### **4.6 Session Termination**

- **Action:** Agents signal the end of the interaction.
    
- **Message Example:**
	```
	{
	  "performative": "INFORM",
	  "sender": "AgentA",
	  "receiver": "AgentB",
	  "content": {
	    "message": "Session terminated."
	  },
	  "language": "JSON",
	  "ontology": "ANEX-Ontology",
	  "protocol": "ANEX-Termination"
	}
 	```    

---

## **5. Implementation Details**

### **5.1 Technology Stack**

- **Programming Languages:** Node.js (JavaScript) and Python.
- **Agent Frameworks:**
    - **For Python:** [SPADE](https://github.com/javipalanca/spade) - Smart Python Agent Development Environment.
    - **For Node.js:** Custom lightweight agent libraries or existing modules supporting FIPA ACL.

### **5.2 Communication Protocols**

- **Transport Layer:** Secure WebSockets (`wss://`) for real-time, bidirectional communication.
- **Serialization Format:** JSON for message content, ensuring readability and ease of debugging.
- **Security Measures:**
    - **Encryption:** Utilize TLS for secure WebSocket connections.
    - **Authentication:** Use simple token-based authentication for the MVP.

### **5.3 Agent Identification and Authentication**

- **Agent Identifiers:** Unique identifiers assigned to each agent (e.g., UUIDs).
- **Authentication Tokens:** Simple tokens exchanged during the handshake for basic authentication.
- **Future Enhancements:** Implement OAuth 2.0 or mutual TLS authentication for robust security.

### **5.4 Ontology Definition**

- **Purpose:** The ontology provides a shared vocabulary and semantic framework that both agents use to interpret the content of messages consistently.
- **Implementation:** Proposed basic ANEX ontology with common terms used in agent interactions:
	- `identity`
	- `owner`
	- `relation`
	- `request_type`
	- `access`
	- `promise`
- **Expansion:** While the initial ontology is kept simple to facilitate basic communication, it is designed to be extensible for future enhancements, allowing for more complex interactions and domain-specific terms.

### **5.5 Error Handling**

- **Standardized Error Messages:** Define a set of error performatives (`FAILURE`, `NOT_UNDERSTOOD`) to communicate issues.
    
- **Example Error Message:**
	```
 	{
	  "performative": "FAILURE",
	  "sender": "AgentB",
	  "receiver": "AgentA",
	  "content": {
	    "error": "Invalid authentication token."
	  },
	  "language": "JSON",
	  "ontology": "ANEX-Ontology",
	  "protocol": "ANEX-Handshaking"
	}
 	```

---

## **6. Use Case Scenario**

### **6.1 Setting Up a Meeting Between Two Agents**

#### **Participants**

- **Agent A:** Personal assistant for Ammon Haggerty.
- **Agent B:** Personal assistant for another individual.

#### **Interaction Flow**

1. **Agent A Initiates Handshake:**
    - Sends a self-identification message and declares ANEX compliance.
2. **Agent A Requests Engagement:**
    - Proposes setting up a meeting.
3. **Agent B Responds:**
    - Agrees to proceed.
4. **Agents Negotiate Terms:**
    - Agent A sends a CFP with requested access and promises.
    - Agent B proposes modifications to the access permissions.
5. **Agreement Reached:**
    - Agents agree on terms.
6. **Data Exchange Occurs:**
    - Agents share available meeting times.
7. **Session Terminates:**
    - Agents confirm the end of the interaction.

---

## **7. Future Required Features**

### **7.1 Enhanced Security and Identity Validation**

- **Mutual TLS Authentication:** Implement mutual TLS for strong agent authentication.
- **OAuth 2.0/OpenID Connect:** Integrate for robust identity and access management.
- **JWTs (JSON Web Tokens):** Use for secure, stateless authentication.

### **7.2 Advanced Negotiation Protocols**

- **Iterated Contract Net Protocol:** For more complex negotiation scenarios.
- **Multi-Agent Negotiation:** Support interactions involving multiple agents simultaneously.

### **7.3 Improved Ontology and Semantics**

- **Ontology Expansion:** Incorporate domain-specific vocabularies.
- **Semantic Understanding:** Use AI techniques to interpret and generate more nuanced proposals.

### **7.4 Compliance and Governance**

- **Regulatory Compliance:** Ensure adherence to data protection regulations like GDPR and CCPA.
- **Audit Logging:** Implement detailed logging for transparency and accountability.

### **7.5 Scalability and Performance Enhancements**

- **Efficient Serialization:** Consider migrating to Protocol Buffers or CBOR for performance.
- **Load Balancing:** Implement mechanisms to distribute agent workloads efficiently.

### **7.6 Human and group support**
- **Support for recipients who are non-compliant:** Allow for initial engagements to branch from a simple verbal or text-based confirmation.
- **Group support:** Including humans and agents (both compliant and non-compliant).

---

## **8. Solutions for Async and Streaming Data**

### **8.1 Asynchronous Communication**

- **WebSockets:** Utilize secure WebSocket connections for real-time, asynchronous messaging.
- **Event-Driven Architecture:** Implement event loops and non-blocking I/O to handle multiple simultaneous interactions.

### **8.2 Streaming Data**

- **FIPA-Subscribe Interaction Protocol:** Use for scenarios requiring continuous data updates.
- **Implementation:**
    - Agent subscribes to a data source.
    - Updates are pushed to the agent as they become available.

### **8.3 Lightweight Security Measures**

- **Secure WebSockets (`wss://`):**
    - Encrypts data in transit using TLS.
    - Provides a secure channel for agent communication.
- **Token-Based Authentication:**
    - Simple tokens exchanged during the handshake.
    - Tokens can be time-bound or session-specific.

---

## **9. Implementation Guidance for Node.js and Python**

### **9.1 Python Implementation Using SPADE**

- **SPADE Framework:**
    - Supports FIPA standards.
    - Built-in XMPP messaging, which can be adapted to use WebSockets.
- **Agent Development:**
    - Define agents as classes inheriting from `spade.agent.Agent`.
    - Implement behaviors for handling messages and protocols.
- **Example:**
    
    ==python==
	```
 	from spade.agent import Agent
	from spade.behaviour import CyclicBehaviour
	from spade.message import Message
	
	class ANEXAgent(Agent):
	    class HandshakeBehaviour(CyclicBehaviour):
	        async def run(self):
	            msg = await self.receive(timeout=10)
	            if msg:
	                # Handle message according to FIPA protocols
	                pass
	
	    async def setup(self):
	        self.add_behaviour(self.HandshakeBehaviour())
 	```
    

### **9.2 Node.js Implementation**

- **Agent Frameworks:**
    - Use lightweight libraries or develop custom agent classes.
- **WebSocket Integration:**
    - Use the `ws` library for WebSocket communication.
- **FIPA Message Handling:**
    - Define message parsing and construction functions according to FIPA ACL.
- **Example:**
    
    ==javascript==
  	```
   	const WebSocket = require('ws');
	
	class ANEXAgent {
	    constructor() {
	        this.ws = new WebSocket('wss://agent-server.com');
	        this.ws.on('message', this.handleMessage.bind(this));
	    }
	
	    handleMessage(data) {
	        const message = JSON.parse(data);
	        // Handle message according to FIPA protocols
	    }
	
	    sendMessage(message) {
	        const data = JSON.stringify(message);
	        this.ws.send(data);
	    }
	}
	```    

---

## **Appendix**

### **A. Key FIPA Performatives**

- **ACCEPT-PROPOSAL**
- **AGREE**
- **CANCEL**
- **CFP (Call for Proposal)**
- **INFORM**
- **NOT-UNDERSTOOD**
- **PROPOSE**
- **QUERY-IF**
- **REFUSE**
- **REQUEST**

### **B. Sample Ontology Entries**

- **ANEX-Ontology Terms:**
    - `identity`
    - `owner`
    - `relation`
    - `request_type`
    - `access`
    - `promise`

---

**Note:** This specification is designed to provide a foundation for the ANEX protocol using FIPA standards. Developers are encouraged to extend and adapt the protocol to meet specific requirements, keeping in mind the importance of security, compliance, and scalability as the system evolves.
