# 📓 Database Engineering Project Log
### Project: Credit Risk & Lending Scoring Engine
### Lead Architect: Alexandre Marcel Mbassi

---

## 📅 Step 1: Local Machine Environment Setup (Windows 11)
*   **Action:** Installed Git for Windows 11 to activate the Linux-style **Git Bash** terminal emulator.
*   **Configuration Safeguards:**
    *   Configured the default terminal text editor to `Notepad` instead of `Vim` to prevent keyboard lockouts.
    *   Overrode legacy repository branch defaults to enforce the modern `main` naming convention.
*   **Key Command Learned:** `pwd` (Print Working Directory) to verify exactly which folder the terminal is standing in before running file modifications.

## 📅 Step 2: Path Directory Initialization & Portability
*   **Action:** Used advanced Git Bash brace expansion to instantly map out a professional, modular project tree.
*   **Command Executed:**
    ```bash
    mkdir -p credit_risk_engine/{.github/workflows,sql,r,data,docs/{textbooks,cheat_sheets}}
    cd credit_risk_engine
    git init
    ```
*   **Architectural Philosophy:** Separating path directories ensures **Absolute Portability**. By using relative references (like `docs/textbooks/`) instead of hardcoded desktop drives (`C:/Users/...`), the code is guaranteed to run identically when moved to external cloud environments.

## 📅 Step 3: Resolving Visual Container Clipping (The 0NF Problem)
*   **The Issue:** Standard markdown data tables containing long, unnormalized string parameters (`Loan_Details` and `Late_Payments_Dates`) were aggressively squeezed and cut off on the left and right edges of display containers.
*   **The Professional Fix:** Employed **Option 1 (Verbatim Fenced Code Blocks)** using the ` ```text ` tag. This locks the string width on your screen and forces a horizontal scroll bar if a viewer's screen is too narrow, preserving every character of data.

## 📅 Step 4: Normalizing the Schema to 3rd Normal Form (3NF)
*   **Data Hygiene Action:** Took a flat-matrix, unnormalized 0NF data feed and systematically decoupled it to eliminate update and deletion anomalies:
    1.  `applicants`: Standardized client legal names, emails, and incomes.
    2.  `loans`: Extracted hidden variables (`loan_amount`, `monthly_installment`, `loan_status`) out of packed text blocks using Regular Expression (Regex) lookbehinds (`(?<=Amt:\\s)\\d+`).
    3.  `loan_payments`: Expanded nested, comma-separated lists (`Late_Payments_Dates`) into unique, independent chronological rows to enforce **First Normal Form (1NF)**.
*   **U.S. Date Standardization:** Integrated the `lubridate::mdy()` function to parse incoming U.S. date strings (`MM/DD/YYYY`) and map them safely into native, queryable database timestamp blocks.

## 📅 Step 5: Advanced Machine Learning Modeling Framework
*   **Action:** Evaluated structural modeling meta-packages and selected **`mlr3`** over the legacy `caret` or `mlr` libraries.
*   **Why `mlr3`:** It utilizes modern Object-Oriented (`R6`) programming patterns similar to Python's `scikit-learn`. It separates modeling layers into distinct, modular objects: `Task` (the data structure), `Learner` (the algorithm), and `Resampling` (cross-validation).
*   **Determinism Guarantee:** Integrated `set.seed(42)` right before random data assignments to lock down the mathematical state, ensuring any external developer or recruiter gets identical calculations upon running the code.

## 📅 Step 6: Git Exclusions & Cloud Automation
*   **Action:** Crafted a `.gitignore` template to block hidden Windows 11 system files (`desktop.ini`, `Thumbs.db`), RStudio runtime logs (`.Rhistory`), and heavy textbook PDF binaries from bloated repository uploads.
*   **Cloud Ingestion Trigger:** Set up `.github/workflows/publish.yml` to automatically rent a temporary Linux server container (`ubuntu-latest`) in the cloud every time code is pushed. The server installs R dependencies, runs the `mlr3` optimization loops, and builds a compiled, interactive HTML presentation website via Quarto.
