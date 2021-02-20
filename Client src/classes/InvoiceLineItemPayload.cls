public class InvoiceLineItemPayload {
    public List<InvoiceLineItem> incomingInvlRecords = new List<InvoiceLineItem>();
    //Class To prepare the Invoice Line Item Payload
    public class InvoiceLineItem {
        public String externalId;
        public String name;
        public String status;
        public Decimal price;
    }
}