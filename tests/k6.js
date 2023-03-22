// brew install k6
import http from 'k6/http';
import { sleep, check } from 'k6';
import { Rate } from 'k6/metrics';

export const errorRate = new Rate('errors');

export const options = {
  vus: 2,
  duration: '5s',
  insecureSkipTLSVerify: true,
  thresholds: {
    http_req_failed: ['rate<0.01'], // http errors should be less than 1%
    http_req_duration: ['p(95)<500'], // 95 percent of response times must be below 500ms
  },
};

export default function () {
  const url = 'http://localhost:80';
  const params = {
    headers: {
      'Host': 'www.demo.io',
      'Content-Type': 'application/json',
    },
  };
  sleep(0.1);
  check(http.get(url, params), {
    'status is 200': (r) => r.status == 200,
  }) || errorRate.add(1);
}
