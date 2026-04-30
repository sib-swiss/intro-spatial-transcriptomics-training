#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd "${script_dir}/.." && pwd)"
raw_dir="${project_root}/data/raw"

mkdir -p "${raw_dir}"

download() {
  local url="$1"
  local dest="$2"
  local expected_size="${3:-}"

  if [[ -n "${expected_size}" && -f "${dest}" ]]; then
    local current_size
    current_size="$(wc -c < "${dest}" | tr -d ' ')"
    if [[ "${current_size}" == "${expected_size}" ]]; then
      echo "Already complete: ${dest}"
      return 0
    fi
  elif [[ -z "${expected_size}" && -s "${dest}" ]]; then
    echo "Already present: ${dest}"
    return 0
  fi

  echo "Downloading/resuming: $(basename "${dest}")"
  curl \
    --location \
    --fail \
    --continue-at - \
    --retry 10 \
    --retry-delay 20 \
    --output "${dest}" \
    "${url}"

  if [[ -n "${expected_size}" ]]; then
    local final_size
    final_size="$(wc -c < "${dest}" | tr -d ' ')"
    if [[ "${final_size}" != "${expected_size}" ]]; then
      echo "Unexpected size for ${dest}" >&2
      echo "Expected: ${expected_size}" >&2
      echo "Observed: ${final_size}" >&2
      echo "Rerun this script to resume." >&2
      exit 1
    fi
  fi
}

visium_base="https://cf.10xgenomics.com/samples/spatial-exp/3.0.0/Visium_HD_Human_Colon_Cancer_P2"
xenium_base="https://cf.10xgenomics.com/samples/xenium/2.0.0/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE"
chromium_base="https://cf.10xgenomics.com/samples/cell-vdj/8.0.0/Human_DTC_5pv2_P5_CRC"

download \
  "${visium_base}/Visium_HD_Human_Colon_Cancer_P2_binned_outputs.tar.gz" \
  "${raw_dir}/Visium_HD_Human_Colon_Cancer_P2_binned_outputs.tar.gz" \
  "15886359364"

download \
  "${visium_base}/Visium_HD_Human_Colon_Cancer_P2_spatial.tar.gz" \
  "${raw_dir}/Visium_HD_Human_Colon_Cancer_P2_spatial.tar.gz"

download \
  "${visium_base}/Visium_HD_Human_Colon_Cancer_P2_metrics_summary.csv" \
  "${raw_dir}/Visium_HD_Human_Colon_Cancer_P2_metrics_summary.csv"

download \
  "${visium_base}/Visium_HD_Human_Colon_Cancer_P2_web_summary.html" \
  "${raw_dir}/Visium_HD_Human_Colon_Cancer_P2_web_summary.html"

download \
  "${visium_base}/Visium_HD_Human_Colon_Cancer_P2_feature_slice.h5" \
  "${raw_dir}/Visium_HD_Human_Colon_Cancer_P2_feature_slice.h5"

download \
  "${xenium_base}/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE_gene_panel.json" \
  "${raw_dir}/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE_gene_panel.json"

download \
  "${xenium_base}/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE_he_image.ome.tif" \
  "${raw_dir}/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE_he_image.ome.tif"

download \
  "${xenium_base}/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE_he_imagealignment.csv" \
  "${raw_dir}/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE_he_imagealignment.csv"

download \
  "${xenium_base}/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE_analysis_summary.html" \
  "${raw_dir}/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE_analysis_summary.html"

download \
  "${xenium_base}/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE_outs.zip" \
  "${raw_dir}/Xenium_V1_Human_Colon_Cancer_P2_CRC_Add_on_FFPE_outs.zip"

download \
  "${chromium_base}/Human_DTC_5pv2_P5_CRC_aggregation.csv" \
  "${raw_dir}/Human_DTC_5pv2_P5_CRC_aggregation.csv"

download \
  "${chromium_base}/Human_DTC_5pv2_P5_CRC_count_feature_reference.csv" \
  "${raw_dir}/Human_DTC_5pv2_P5_CRC_count_feature_reference.csv"

download \
  "${chromium_base}/Human_DTC_5pv2_P5_CRC_count_filtered_feature_bc_matrix.h5" \
  "${raw_dir}/Human_DTC_5pv2_P5_CRC_count_filtered_feature_bc_matrix.h5"

echo "Downloads complete."
echo "Raw files: ${raw_dir}"
echo "Run scripts/prepare_2026_course_data.qmd to assemble data/Human_Colon_Cancer_P2/."
