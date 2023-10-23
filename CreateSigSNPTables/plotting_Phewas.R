# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load your PheWAS dataset
# Replace 'your_dataset.csv' with the actual path to your dataset
phe_was_data <- read.csv("test_CD160")

# List of tissues you want to analyze
tissues_of_interest <- c("Tissue1", "Tissue2", "Tissue3")

# Create PheWAS plots for each tissue
for (tissue in tissues_of_interest) {
  # Filter the dataset for the current tissue
  tissue_data <- phe_was_data %>% filter(Tissue == tissue)
  
  # Create a PheWAS graph for the current tissue
  phe_was_plot <- ggplot(data = tissue_data, aes(x = Phenotype, y = PValue)) +
    geom_point() +
    labs(title = paste("PheWAS for", tissue),
         x = "Phenotype",
         y = "-log10(P-Value)") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  # Customize the plot appearance as needed
  
  # Display the PheWAS plot for the current tissue
  print(phe_was_plot)
}
