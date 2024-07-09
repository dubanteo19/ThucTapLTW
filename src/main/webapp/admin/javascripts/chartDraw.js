const ctx = document.getElementById('doanhThuChart');
const DATA_COUNT = 6;
const NUMBER_CFG = {count: DATA_COUNT, min: 0, max: 10000000};
function renderChart(months,revenues) {
    const labels = months.map(m => "Tháng " + m);
    console.log(revenues)
    console.log(labels)
    // const labels = ["thang 1","thang 2","thang 3","thang 4","thang 4","thang 5","thang 6",]
    const data = {
        labels: labels,
        datasets: [{
            label: 'Doanh thu',
            data: revenues,
            borderColor: '#A7D397',
            backgroundColor: '#A7D397'
        },
            {
                label: 'Lợi nhuận',
                data: [10, 14, 30, 10, 20, 60],
                borderColor: '#F5EEC8',
                backgroundColor: '#F5EEC8',
            }
        ]
    };
    const config = {
        type: 'bar',
        data: data,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                }
            }
        },
    };
    new Chart(ctx, config);
}