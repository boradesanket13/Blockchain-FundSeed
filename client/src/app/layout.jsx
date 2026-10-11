import { Epilogue } from "next/font/google";
import 'react-toastify/dist/ReactToastify.css';

import "./globals.css";
import { Layout, Providers } from "@/components";

const epilogue = Epilogue({ subsets: ["latin"] });

export const metadata = {
  title: {
    default: "FundSeed | Decentralized Crowdfunding",
    template: "%s | FundSeed",
  },
  applicationName: "FundSeed",
  description:
    "FundSeed is a decentralized crowdfunding platform built on Ethereum. Create fundraising campaigns, support ideas, and manage contributions with a connected wallet.",
  authors: [{ name: "Sanket Borade", url: "https://github.com/boradesanket13" }],
  creator: "Sanket Borade",
  openGraph: {
    title: "FundSeed | Decentralized Crowdfunding",
    description:
      "Create crowdfunding campaigns and support ideas through a decentralized Ethereum-powered platform.",
    siteName: "FundSeed",
    type: "website",
  },
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={epilogue.className}>
        <Providers>
          <Layout>{children}</Layout>
        </Providers>
      </body>
    </html>
  );
}
