FROM exiasr/alpine-yarn-nginx
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn
COPY src ./src
COPY public ./public
RUN yarn build
RUN ["rm", "-rfv", "/usr/share/nginx/html"]
RUN ["cp", "-rfv", "/usr/src/app/build", "/usr/share/nginx/html"]
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]