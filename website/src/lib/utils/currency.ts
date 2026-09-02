/**
 * South Asian Number Formatting for Bangladeshi Taka (Lakh / Crore system).
 * Example: 2550000 -> "৳ 25,50,000"
 */

const BENGALI_DIGITS: Record<string, string> = {
  "0": "০",
  "1": "১",
  "2": "২",
  "3": "৩",
  "4": "৪",
  "5": "৫",
  "6": "৬",
  "7": "৭",
  "8": "৮",
  "9": "৯",
};

export function formatBDT(
  amount: number | string | null | undefined,
  options: { isBangla?: boolean; showSymbol?: boolean; fractionDigits?: number } = {}
): string {
  if (amount === null || amount === undefined) return "৳ 0";

  const num = typeof amount === "string" ? parseFloat(amount) : amount;
  if (isNaN(num)) return "৳ 0";

  const isBangla = options.isBangla ?? false;
  const showSymbol = options.showSymbol ?? true;
  const fractionDigits = options.fractionDigits ?? 0;

  // Split integer and decimal parts
  const parts = num.toFixed(fractionDigits).split(".");
  let intPart = parts[0];
  const decPart = parts.length > 1 && fractionDigits > 0 ? `.${parts[1]}` : "";

  // Apply South Asian grouping (last 3 digits, then groups of 2 digits)
  if (intPart.length > 3) {
    const lastThree = intPart.substring(intPart.length - 3);
    const otherNumbers = intPart.substring(0, intPart.length - 3);
    const formattedOther = otherNumbers.replace(/\B(?=(\d{2})+(?!\d))/g, ",");
    intPart = `${formattedOther},${lastThree}`;
  }

  let formatted = `${intPart}${decPart}`;

  if (isBangla) {
    formatted = formatted.replace(/\d/g, (d) => BENGALI_DIGITS[d] || d);
  }

  return showSymbol ? `৳ ${formatted}` : formatted;
}

export function formatCompactBDT(amount: number | string, isBangla: boolean = false): string {
  const num = typeof amount === "string" ? parseFloat(amount) : amount;
  if (isNaN(num)) return "৳ 0";

  if (num >= 10000000) {
    const crore = (num / 10000000).toFixed(2);
    return isBangla ? `৳ ${crore.replace(/\d/g, (d) => BENGALI_DIGITS[d] || d)} কোটি` : `৳ ${crore} Crore`;
  } else if (num >= 100000) {
    const lakh = (num / 100000).toFixed(2);
    return isBangla ? `৳ ${lakh.replace(/\d/g, (d) => BENGALI_DIGITS[d] || d)} লাখ` : `৳ ${lakh} Lakh`;
  }
  return formatBDT(num, { isBangla });
}

export function toBengaliNumerals(strOrNum: string | number): string {
  const str = String(strOrNum);
  return str.replace(/\d/g, (d) => BENGALI_DIGITS[d] || d);
}
