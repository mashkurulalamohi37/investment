const fs = require("fs");
const path = require("path");

const docsDir = path.join(__dirname, "..", "public", "documents");
if (!fs.existsSync(docsDir)) {
  fs.mkdirSync(docsDir, { recursive: true });
}

function createMinimalPdf(title, subtitle) {
  // A clean and valid PDF 1.4 representation
  const escapedTitle = title.replace(/[()\\]/g, "\\$&");
  const escapedSubtitle = subtitle.replace(/[()\\]/g, "\\$&");

  const stream = 
`BT
/F1 18 Tf
50 720 Td
(${escapedTitle}) Tj
ET
BT
/F1 12 Tf
50 690 Td
(${escapedSubtitle}) Tj
ET
BT
/F1 10 Tf
50 650 Td
(Swapnojatri Investment Platform - Official Cryptographic Vault Document) Tj
ET
BT
/F1 9 Tf
50 630 Td
(Fiduciary Custody: The City Bank PLC Escrow Trust) Tj
ET
BT
/F1 9 Tf
50 610 Td
(Verification Standard: SHA-256 Checksum Immutable Hash) Tj
ET
BT
/F1 8 Tf
50 580 Td
(This document is released for verified investor and public audit review.) Tj
ET
`;

  const streamBytes = Buffer.from(stream, "utf-8");
  const streamLength = streamBytes.length;

  let out = "%PDF-1.4\n";
  const offsets = [];

  function addObj(content) {
    offsets.push(Buffer.byteLength(out, "utf-8"));
    out += content;
  }

  addObj("1 0 obj\n<< /Type /Catalog /Pages 2 0 R >>\nendobj\n");
  addObj("2 0 obj\n<< /Type /Pages /Kids [3 0 R] /Count 1 >>\nendobj\n");
  addObj("3 0 obj\n<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 4 0 R /Resources << /Font << /F1 5 0 R >> >> >>\nendobj\n");
  addObj(`4 0 obj\n<< /Length ${streamLength} >>\nstream\n${stream}endstream\nendobj\n`);
  addObj("5 0 obj\n<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>\nendobj\n");

  const startXref = Buffer.byteLength(out, "utf-8");
  out += "xref\n";
  out += `0 ${offsets.length + 1}\n`;
  out += "0000000000 65535 f \n";
  for (const offset of offsets) {
    out += String(offset).padStart(10, "0") + " 00000 n \n";
  }
  out += "trailer\n";
  out += `<< /Size ${offsets.length + 1} /Root 1 0 R >>\n`;
  out += "startxref\n";
  out += `${startXref}\n`;
  out += "%%EOF\n";

  return Buffer.from(out, "utf-8");
}

const files = [
  { name: "prospectus.pdf", title: "LandVest 100 Partnership Deed", subtitle: "Detailed prospectus and legal framework" },
  { name: "agreement.pdf", title: "The City Bank PLC Escrow Agreement", subtitle: "Escrow clearing and fiduciary trust terms" },
  { name: "faq.pdf", title: "Audited Expense Ledger & FAQ Guide", subtitle: "Platform audit policies and investor guide" },
  { name: "landvest-100-prospectus.pdf", title: "LandVest 100 Official Prospectus", subtitle: "Washpur Bosila Bridge project details" },
  { name: "investment-agreement.pdf", title: "General Investment Agreement", subtitle: "Co-ownership contract & dividend distribution" },
  { name: "agro-prospectus.pdf", title: "Smart Agro & High-Yield Farm Prospectus", subtitle: "Seasonal crop yields and smart farm infrastructure" },
  { name: "dairy-prospectus.pdf", title: "Modern Dairy Processing Prospectus", subtitle: "Savar dairy zone venture summary" },
  { name: "veterinary-guidelines.pdf", title: "Veterinary Guidelines & Livestock Policy", subtitle: "Livestock vaccination, biosecurity and compliance" },
];

files.forEach((f) => {
  const targetPath = path.join(docsDir, f.name);
  fs.writeFileSync(targetPath, createMinimalPdf(f.title, f.subtitle));
  console.log("Created valid PDF at:", targetPath);
});
console.log("All sample PDF documents generated successfully!");
