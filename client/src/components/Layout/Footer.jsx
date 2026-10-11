import Link from "next/link";
import { FiGithub, FiHeart } from "react-icons/fi";

const Footer = () => {
  return (
    <footer className="mt-12 border-t border-neutral-800 py-6 text-sm text-neutral-400">
      <div className="flex flex-col items-center justify-between gap-3 sm:flex-row">
        <Link href="/" className="font-semibold tracking-wide text-white transition-colors hover:text-emerald-400">
          FundSeed
        </Link>
        <p className="flex flex-wrap items-center justify-center gap-1 text-center">
          Built with <FiHeart className="text-emerald-400" aria-label="love" /> by
          <a
            href="https://github.com/boradesanket13"
            target="_blank"
            rel="noreferrer noopener"
            className="font-medium text-neutral-200 transition-colors hover:text-emerald-400"
          >
            Sanket Borade
          </a>
        </p>
        <a
          href="https://github.com/boradesanket13"
          target="_blank"
          rel="noreferrer noopener"
          aria-label="Sanket Borade on GitHub"
          className="inline-flex items-center gap-2 transition-colors hover:text-emerald-400"
        >
          <FiGithub className="text-lg" />
          GitHub
        </a>
      </div>
    </footer>
  );
};

export default Footer;
