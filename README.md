# Explainable ML for Cross-National Diabetes Risk Prediction

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Python 3.10+](https://img.shields.io/badge/Python-3.10+-green.svg)](https://python.org)
[![Web Dashboard](https://img.shields.io/badge/Dashboard-Live-orange.svg)](https://ebp-diabetes-prediction.vercel.app)

> A multi-method framework integrating survival analysis, machine learning, deep learning, SHAP interpretability, and algorithmic fairness assessment for diabetes onset prediction in a multi-national East Asian cohort (N=10,000).

**Manuscript submitted to:** BMC Medical Informatics and Decision Making

---

## Key Findings

| Metric | Value |
|--------|-------|
| Cohort | 10,000 participants, 5-year follow-up |
| Diabetes incidence | 7.91% (n=791) |
| Best ML model | XGBoost (Optuna-tuned), AUC=0.651 |
| Best DL model | GRU+Attention, AUC=0.637 |
| Top predictor (SHAP) | BMI (0.172), Family history (0.137), HbA1c (0.131) |
| Fairness (ΔAUC) | < 0.02 across nationality and sex subgroups |

## Project Structure

```
.
├── README.md
├── LICENSE
├── requirements.txt
├── .gitignore
│
├── src/                          # Analysis pipeline
│   ├── 01_environment_data_eda.py    # Cell 1: Setup, data loading, EDA
│   ├── 02_survival_ml_shap.py        # Cell 2: Survival, ML (Optuna), SHAP
│   ├── 03_deep_learning.py           # Cell 3: LSTM, GRU, Transformer (Optuna)
│   ├── 04_fairness_analysis.py       # Cell 4: Algorithmic fairness
│   └── Diabetes_Full_Analysis.ipynb  # Complete Colab notebook
│
├── figures/                      # All output visualizations
│   ├── 01_EDA/                       # Biomarker distributions, correlations
│   ├── 02_Survival/                  # KM curves, forest plots, Cox results
│   ├── 03_ML/                        # ROC, PR, calibration, feature importance
│   ├── 04_SHAP/                      # Beeswarm, nationality heatmap, dependence
│   └── 05_DL/                        # Training curves, attention, t-SNE
│
├── data/
│   └── sample_data.csv               # Sample dataset (30 patients)
│
├── models/                       # Saved model weights
│   └── .gitkeep
│
├── web/                          # Web dashboard
│   └── index.html                    # Vercel-deployed dashboard
│
├── app/                          # Mobile applications
│   ├── android/                      # Android Studio project
│   └── ios/                          # Xcode project
│
└── docs/                         # Manuscript & reports
    ├── Manuscript_BMC_MIDM_v2.docx   # Final manuscript
    └── 저널투고_타당성보고서.docx        # Journal feasibility report
```

## Analysis Pipeline

```
Stage 1: EDA          → Biomarker distributions, ANOVA, trajectories
Stage 2: Survival     → Kaplan-Meier, Cox PH, time-dependent AUC
Stage 3: ML           → LR, RF, XGBoost (Optuna 50 trials each)
Stage 4: Deep Learning→ LSTM+Attn, GRU+Attn, Transformer (Optuna 20 trials)
Stage 5: SHAP         → Global/local interpretability, cross-national comparison
Stage 6: Fairness     → Equalized odds, calibration equity, SHAP fairness
```

## Quick Start

### 1. Google Colab (Recommended)
Open `src/Diabetes_Full_Analysis.ipynb` in Google Colab and run all cells sequentially.

### 2. Local Environment
```bash
pip install -r requirements.txt
cd src
python 01_environment_data_eda.py
python 02_survival_ml_shap.py
python 03_deep_learning.py
python 04_fairness_analysis.py
```

### 3. Web Dashboard
Visit: [https://ebp-diabetes-prediction.vercel.app](https://ebp-diabetes-prediction.vercel.app)

### 4. Mobile App
- **Android**: Open `app/android/` in Android Studio → Run
- **iOS**: Open `app/ios/EBP_Diabetes.xcodeproj` in Xcode → Run

## TRIPOD+AI Compliance

This study follows the [TRIPOD+AI guidelines](https://doi.org/10.1136/bmj-2023-078378) (BMJ, 2024) for transparent reporting of AI-based prediction models, including:
- Model development and validation methodology
- Algorithmic fairness assessment
- Calibration evaluation
- SHAP-based interpretability

## Citation

```bibtex
@article{choi2026diabetes,
  title={Explainable Machine Learning for Cross-National Diabetes Risk Prediction:
         A Multi-Method Approach with SHAP Interpretation and Clinical Dashboard},
  author={Choi, Wansuk},
  journal={BMC Medical Informatics and Decision Making},
  year={2026},
  institution={Kyungwoon University}
}
```

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

## Contact

**Wansuk Choi** - Department of Physical Therapy, Kyungwoon University
Email: y3korea@gmail.com
