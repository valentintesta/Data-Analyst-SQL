import streamlit as st
import pandas as pd
import plotly.express as px
import seaborn as sns # type: ignore
import matplotlib.pyplot as plt

# Streamlit configuration
st.set_page_config(
    page_title="Fintech LoanDashboard",
    layout="wide",
    initial_sidebar_state="expanded",
)

# Custom styles for branding (dark green background and green text)
st.markdown("""
    <style>
    .main {
        background-color: #2E865F; /* Dark green background */
    }
    .sidebar .sidebar-content {
        background-color: #1E1E1E; /* Dark background */
    }
    h1, h2, h3 {
        color: white; /* White for titles */
    }
    p, div {
        color: #34C759; /* Brighter green for regular text */
    }
    .stButton>button {
        background-color: #3E8E41; /* Dark green */
        color: white;
    }
    </style>
""", unsafe_allow_html=True)

# Load data from CSV file
@st.cache_data
def load_data():
    try:
        df = pd.read_csv(r"C:\Users\valen\OneDrive\Desktop\DATA APP\Data-Analytcs\SQL\Fintech-Performance-SQL-Python\Data\df_merged (1).csv")
        return df
    except FileNotFoundError:
        st.error("Error: The file 'df_merged (1).csv' was not found. Please check the file path.")
        return None
    except Exception as e:
        st.error(f"An error occurred while loading data: {e}")
        return None

df_merged = load_data()

# Check if the dataframe is loaded correctly before proceeding
if df_merged is not None:
    # Title of the dashboard
    st.title("Fintech Loan Dashboard")
    
    # Mostrar mensaje de éxito después del título
    st.success("Data loaded successfully!")

    # Filter data based on user selection
    filtered_data = df_merged.copy()  # Initialize filtered_data with a copy of df_merged
    
    # Sidebar filters
    st.sidebar.header("Filters")
    
    if 'region' in df_merged.columns:
        region_filter = st.sidebar.selectbox("Select a region:", df_merged["region"].unique())
    else:
        st.sidebar.error("Column 'region' not found in the data.")
    
    if 'loan_status' in df_merged.columns:
        status_filter = st.sidebar.multiselect("Select loan status:", df_merged["loan_status"].unique())
    else:
        st.sidebar.error("Column 'loan_status' not found in the data.")
    
    if 'purpose' in df_merged.columns:
        purpose_filter = st.sidebar.multiselect("Select Loan Purpose:", df_merged["purpose"].unique())
    else:
        st.sidebar.error("Column 'purpose' not found in the data.")
    
    if 'issue_year' in df_merged.columns:
        issue_year_filter = st.sidebar.multiselect("Select Issue Year:", df_merged["issue_year"].unique())
    else:
        st.sidebar.error("Column 'issue_year' not found in the data.")
    
    if 'issue_month' in df_merged.columns:
        issue_month_filter = st.sidebar.multiselect("Select Issue Month:", df_merged["issue_month"].unique())
    else:
        st.sidebar.error("Column 'issue_month' not found in the data.")

    if region_filter:
        filtered_data = filtered_data[filtered_data["region"] == region_filter]
    
    if status_filter:
        filtered_data = filtered_data[filtered_data["loan_status"].isin(status_filter)]
    
    if purpose_filter:
        filtered_data = filtered_data[filtered_data["purpose"].isin(purpose_filter)]
    
    if issue_year_filter:
        filtered_data = filtered_data[filtered_data["issue_year"].isin(issue_year_filter)]
    
    if issue_month_filter:
        filtered_data = filtered_data[filtered_data["issue_month"].isin(issue_month_filter)]

    # Metrics Section
    st.subheader("Key Metrics")
    col1, col2, col3 = st.columns(3)
    col4, col5, col6 = st.columns(3)

    if 'annual_inc' in filtered_data.columns and 'loan_amount' in filtered_data.columns and 'funded_amount' in filtered_data.columns:
        total_income = filtered_data['annual_inc'].sum()
        total_loans = filtered_data['loan_amount'].sum()
        total_funded = filtered_data['funded_amount'].sum()
        
        col1.metric(label="Total Annual Income", value=f"${total_income:,.2f}")
        col2.metric(label="Total Loan Amount", value=f"${total_loans:,.2f}")
        col3.metric(label="Total Funded Amount", value=f"${total_funded:,.2f}")

    if 'avg_cur_bal' in filtered_data.columns:
        avg_cur_bal = filtered_data['avg_cur_bal'].mean()
        col4.metric(label="Average Current Balance", value=f"${avg_cur_bal:,.2f}")

    if 'tot_cur_bal' in filtered_data.columns:
        tot_cur_bal = filtered_data['tot_cur_bal'].mean()
        col5.metric(label="Total Current Balance", value=f"${tot_cur_bal:,.2f}")

    if 'int_rate' in filtered_data.columns:
        avg_int_rate = filtered_data['int_rate'].mean() * 100
        col6.metric(label="Average Interest Rate", value=f"{avg_int_rate:.2f}%")

    else:
        st.error("Required columns for metrics not found.")

    # Display filtered data
    st.subheader("Raw Data")
    st.dataframe(filtered_data)

    # Data visualizations
    st.subheader("Interactive Visualizations")

    # Bar chart: Loan purpose: total amount
    st.subheader("Loan Purpose: Total Amount")
    if 'purpose' in filtered_data.columns and 'loan_amount' in filtered_data.columns:
        fig = px.bar(filtered_data, x="purpose", y="loan_amount", title="Loan Purpose: Total Amount", color_discrete_sequence=["#34C759"])
        st.plotly_chart(fig, use_container_width=True)
    else:
        st.error("Columns 'purpose' or 'loan_amount' not found for the bar chart.")

    # Pie chart: Loan status distribution
    st.subheader("Loan Status Distribution")
    if 'loan_status' in filtered_data.columns:
        status_counts = filtered_data["loan_status"].value_counts().reset_index()
        status_counts.columns = ['loan_status', 'count']
        fig2 = px.pie(status_counts, names='loan_status', values='count', title='Loan Status Distribution', color_discrete_sequence=["#34C759"])
        st.plotly_chart(fig2, use_container_width=True)
    else:
        st.error("Column 'loan_status' not found for the pie chart.")

    # Bar chart: Annual Income vs Loan Amount
    st.subheader("Annual Income vs Loan Amount")
    if 'annual_inc' in filtered_data.columns and 'loan_amount' in filtered_data.columns:
        data = {
            'Category': ['Annual Income', 'Loan Amount'],
            'Value': [filtered_data['annual_inc'].mean(), filtered_data['loan_amount'].mean()]
        }
        df = pd.DataFrame(data)
        
        # Utiliza Plotly para un gráfico más interactivo
        fig = px.bar(df, x='Category', y='Value', title="Annual Income vs Loan Amount", color_discrete_sequence=["#34C759"])
        st.plotly_chart(fig, use_container_width=True)
    else:
        st.error("Columns 'annual_inc' or 'loan_amount' not found for the bar chart.")

    # Heatmap: Correlation between loan features
    st.subheader("Correlation Heatmap")
    if 'loan_amount' in filtered_data.columns and 'int_rate' in filtered_data.columns and 'annual_inc' in filtered_data.columns:
        correlation_matrix = filtered_data[['loan_amount', 'int_rate', 'annual_inc']].corr()
        fig4 = px.imshow(correlation_matrix, text_auto=True, title='Correlation Heatmap', color_continuous_scale=["#34C759", "#2E865F"])
        st.plotly_chart(fig4, use_container_width=True)

    # Footer for branding
    st.markdown("""
        <hr style='border-color:#34C759;'>
        <p style='text-align:center;color:white;'> 2025 Business Insights - All rights reserved</p>
    """, unsafe_allow_html=True)
else:
    st.warning("Please ensure the data file is correctly loaded to display the dashboard.")
