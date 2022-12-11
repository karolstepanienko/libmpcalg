% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src')

% Object parameters
ny = 2;  % Number of outputs
nu = 2;  % Number of inputs
InputDelay = [1; 1];
osf = 1;  % Object sampling factor

% Object model
stepResponse = cell(nu, 1);
% For choosen input, horizontal vectors of step responses for consecutive
% outputs
stepResponse{1, 1} = [0 0; 0 0; 0.0952 0.0984; 0.1813 0.1935; 0.2592 0.2855; 0.3297 0.3745; 0.3935 0.4606; 0.4512 0.5438; 0.5034 0.6243; 0.5507 0.7022; 0.5934 0.7775; 0.6321 0.8504; 0.6671 0.9209; 0.6988 0.9890; 0.7275 1.0550; 0.7534 1.1187; 0.7769 1.1804; 0.7981 1.2401; 0.8173 1.2978; 0.8347 1.3536; 0.8504 1.4075; 0.8647 1.4597; 0.8775 1.5102; 0.8892 1.5591; 0.8997 1.6063; 0.9093 1.6520; 0.9179 1.6962; 0.9257 1.7389; 0.9328 1.7803; 0.9392 1.8203; 0.9450 1.8590; 0.9502 1.8964; 0.9550 1.9325; 0.9592 1.9675; 0.9631 2.0014; 0.9666 2.0341; 0.9698 2.0658; 0.9727 2.0964; 0.9753 2.1260; 0.9776 2.1547; 0.9798 2.1824; 0.9817 2.2092; 0.9834 2.2351; 0.9850 2.2602; 0.9864 2.2845; 0.9877 2.3079; 0.9889 2.3306; 0.9899 2.3526; 0.9909 2.3738; 0.9918 2.3943; 0.9926 2.4142; 0.9933 2.4334; 0.9939 2.4519; 0.9945 2.4699; 0.9950 2.4873; 0.9955 2.5041; 0.9959 2.5204; 0.9963 2.5361; 0.9967 2.5513; 0.9970 2.5660; 0.9973 2.5802; 0.9975 2.5940; 0.9978 2.6073; 0.9980 2.6202; 0.9982 2.6326; 0.9983 2.6447; 0.9985 2.6563; 0.9986 2.6676; 0.9988 2.6785; 0.9989 2.6890; 0.9990 2.6992; 0.9991 2.7091; 0.9992 2.7186; 0.9993 2.7278; 0.9993 2.7368; 0.9994 2.7454; 0.9994 2.7537; 0.9995 2.7618; 0.9995 2.7696; 0.9996 2.7772; 0.9996 2.7845; 0.9997 2.7915; 0.9997 2.7984; 0.9997 2.8050; 0.9998 2.8114; 0.9998 2.8176; 0.9998 2.8236; 0.9998 2.8293; 0.9998 2.8349; 0.9998 2.8403; 0.9999 2.8456; 0.9999 2.8506; 0.9999 2.8555; 0.9999 2.8603; 0.9999 2.8649; 0.9999 2.8693; 0.9999 2.8736; 0.9999 2.8777; 0.9999 2.8817; 0.9999 2.8856; 0.9999 2.8894; 1.0000 2.8930; 1.0000 2.8965; 1.0000 2.8999; 1.0000 2.9032; 1.0000 2.9063; 1.0000 2.9094; 1.0000 2.9124; 1.0000 2.9153; 1.0000 2.9180; 1.0000 2.9207; 1.0000 2.9233; 1.0000 2.9258; 1.0000 2.9283; 1.0000 2.9306; 1.0000 2.9329; 1.0000 2.9351; 1.0000 2.9372; 1.0000 2.9393; 1.0000 2.9413; 1.0000 2.9432; 1.0000 2.9451; 1.0000 2.9469; 1.0000 2.9486; 1.0000 2.9503; 1.0000 2.9519; 1.0000 2.9535; 1.0000 2.9550; 1.0000 2.9565; 1.0000 2.9579; 1.0000 2.9593; 1.0000 2.9606; 1.0000 2.9619; 1.0000 2.9632; 1.0000 2.9644; 1.0000 2.9655; 1.0000 2.9667; 1.0000 2.9678; 1.0000 2.9688; 1.0000 2.9698; 1.0000 2.9708; 1.0000 2.9718; 1.0000 2.9727; 1.0000 2.9736; 1.0000 2.9745; 1.0000 2.9753; 1.0000 2.9761; 1.0000 2.9769; 1.0000 2.9777; 1.0000 2.9784; 1.0000 2.9791; 1.0000 2.9798; 1.0000 2.9804; 1.0000 2.9811; 1.0000 2.9817; 1.0000 2.9823; 1.0000 2.9829; 1.0000 2.9835; 1.0000 2.9840; 1.0000 2.9845; 1.0000 2.9850; 1.0000 2.9855; 1.0000 2.9860; 1.0000 2.9865; 1.0000 2.9869; 1.0000 2.9873; 1.0000 2.9877; 1.0000 2.9881; 1.0000 2.9885; 1.0000 2.9889; 1.0000 2.9893; 1.0000 2.9896; 1.0000 2.9900; 1.0000 2.9903; 1.0000 2.9906; 1.0000 2.9909; 1.0000 2.9912; 1.0000 2.9915; 1.0000 2.9918; 1.0000 2.9921; 1.0000 2.9923; 1.0000 2.9926; 1.0000 2.9928; 1.0000 2.9930; 1.0000 2.9933; 1.0000 2.9935; 1.0000 2.9937; 1.0000 2.9939; 1.0000 2.9941; 1.0000 2.9943; 1.0000 2.9945; 1.0000 2.9947; 1.0000 2.9948; 1.0000 2.9950; 1.0000 2.9952; 1.0000 2.9953; 1.0000 2.9955; 1.0000 2.9956; 1.0000 2.9958; 1.0000 2.9959; 1.0000 2.9961; 1.0000 2.9962; 1.0000 2.9963; 1.0000 2.9964; 1.0000 2.9965; 1.0000 2.9967; 1.0000 2.9968; 1.0000 2.9969; 1.0000 2.9970; 1.0000 2.9971; 1.0000 2.9972; 1.0000 2.9973; 1.0000 2.9974; 1.0000 2.9974; 1.0000 2.9975; 1.0000 2.9976; 1.0000 2.9977; 1.0000 2.9978; 1.0000 2.9978; 1.0000 2.9979; 1.0000 2.9980; 1.0000 2.9980; 1.0000 2.9981; 1.0000 2.9982; 1.0000 2.9982; 1.0000 2.9983; 1.0000 2.9983; 1.0000 2.9984; 1.0000 2.9984; 1.0000 2.9985; 1.0000 2.9985; 1.0000 2.9986; 1.0000 2.9986; 1.0000 2.9987; 1.0000 2.9987; 1.0000 2.9988; 1.0000 2.9988; 1.0000 2.9989; 1.0000 2.9989; 1.0000 2.9989; 1.0000 2.9990; 1.0000 2.9990; 1.0000 2.9990; 1.0000 2.9991; 1.0000 2.9991; 1.0000 2.9991; 1.0000 2.9991; 1.0000 2.9992; 1.0000 2.9992; 1.0000 2.9992; 1.0000 2.9993; 1.0000 2.9993; 1.0000 2.9993; 1.0000 2.9993; 1.0000 2.9993; 1.0000 2.9994; 1.0000 2.9994; 1.0000 2.9994; 1.0000 2.9994; 1.0000 2.9994; 1.0000 2.9995; 1.0000 2.9995; 1.0000 2.9995; 1.0000 2.9995; 1.0000 2.9995; 1.0000 2.9995; 1.0000 2.9996; 1.0000 2.9996; 1.0000 2.9996; 1.0000 2.9996; 1.0000 2.9996; 1.0000 2.9996; 1.0000 2.9996; 1.0000 2.9997; 1.0000 2.9997; 1.0000 2.9997; 1.0000 2.9997; 1.0000 2.9997; 1.0000 2.9997; 1.0000 2.9997; 1.0000 2.9997; 1.0000 2.9997; 1.0000 2.9997; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9998; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 2.9999; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000; 1.0000 3.0000];
stepResponse{2, 1} = [0 0; 0 0; 0.0975 0.0988; 0.1903 0.1951; 0.2786 0.2890; 0.3625 0.3807; 0.4424 0.4700; 0.5184 0.5572; 0.5906 0.6422; 0.6594 0.7251; 0.7247 0.8059; 0.7869 0.8848; 0.8461 0.9617; 0.9024 1.0367; 0.9559 1.1099; 1.0068 1.1812; 1.0553 1.2508; 1.1013 1.3187; 1.1452 1.3849; 1.1869 1.4495; 1.2265 1.5125; 1.2642 1.5739; 1.3001 1.6338; 1.3343 1.6922; 1.3667 1.7492; 1.3976 1.8048; 1.4270 1.8590; 1.4549 1.9118; 1.4815 1.9634; 1.5068 2.0137; 1.5309 2.0627; 1.5537 2.1105; 1.5755 2.1572; 1.5962 2.2027; 1.6159 2.2471; 1.6346 2.2903; 1.6525 2.3326; 1.6694 2.3737; 1.6855 2.4139; 1.7009 2.4530; 1.7155 2.4912; 1.7293 2.5285; 1.7425 2.5648; 1.7551 2.6002; 1.7670 2.6348; 1.7784 2.6685; 1.7892 2.7014; 1.7995 2.7335; 1.8093 2.7647; 1.8186 2.7952; 1.8274 2.8250; 1.8358 2.8540; 1.8438 2.8823; 1.8515 2.9099; 1.8587 2.9368; 1.8656 2.9630; 1.8721 2.9886; 1.8784 3.0136; 1.8843 3.0380; 1.8900 3.0617; 1.8953 3.0849; 1.9004 3.1075; 1.9053 3.1295; 1.9099 3.1510; 1.9143 3.1720; 1.9185 3.1924; 1.9225 3.2124; 1.9262 3.2318; 1.9298 3.2508; 1.9333 3.2693; 1.9365 3.2873; 1.9396 3.3049; 1.9426 3.3221; 1.9454 3.3388; 1.9480 3.3551; 1.9506 3.3711; 1.9530 3.3866; 1.9553 3.4017; 1.9574 3.4165; 1.9595 3.4309; 1.9615 3.4450; 1.9634 3.4587; 1.9652 3.4720; 1.9669 3.4851; 1.9685 3.4978; 1.9700 3.5102; 1.9715 3.5223; 1.9729 3.5341; 1.9742 3.5456; 1.9754 3.5568; 1.9766 3.5677; 1.9778 3.5784; 1.9789 3.5888; 1.9799 3.5990; 1.9809 3.6089; 1.9818 3.6185; 1.9827 3.6279; 1.9835 3.6371; 1.9843 3.6461; 1.9851 3.6548; 1.9858 3.6633; 1.9865 3.6717; 1.9872 3.6798; 1.9878 3.6877; 1.9884 3.6954; 1.9890 3.7029; 1.9895 3.7102; 1.9900 3.7174; 1.9905 3.7244; 1.9910 3.7312; 1.9914 3.7378; 1.9918 3.7443; 1.9922 3.7506; 1.9926 3.7568; 1.9930 3.7628; 1.9933 3.7686; 1.9936 3.7743; 1.9939 3.7799; 1.9942 3.7853; 1.9945 3.7906; 1.9948 3.7958; 1.9950 3.8009; 1.9953 3.8058; 1.9955 3.8106; 1.9957 3.8152; 1.9959 3.8198; 1.9961 3.8243; 1.9963 3.8286; 1.9965 3.8328; 1.9967 3.8370; 1.9968 3.8410; 1.9970 3.8449; 1.9971 3.8487; 1.9973 3.8525; 1.9974 3.8561; 1.9975 3.8597; 1.9977 3.8631; 1.9978 3.8665; 1.9979 3.8698; 1.9980 3.8730; 1.9981 3.8762; 1.9982 3.8792; 1.9983 3.8822; 1.9983 3.8851; 1.9984 3.8879; 1.9985 3.8907; 1.9986 3.8934; 1.9986 3.8960; 1.9987 3.8986; 1.9988 3.9011; 1.9988 3.9035; 1.9989 3.9059; 1.9989 3.9083; 1.9990 3.9105; 1.9990 3.9127; 1.9991 3.9149; 1.9991 3.9170; 1.9992 3.9190; 1.9992 3.9210; 1.9993 3.9230; 1.9993 3.9249; 1.9993 3.9267; 1.9994 3.9285; 1.9994 3.9303; 1.9994 3.9320; 1.9995 3.9337; 1.9995 3.9353; 1.9995 3.9369; 1.9995 3.9385; 1.9996 3.9400; 1.9996 3.9415; 1.9996 3.9429; 1.9996 3.9444; 1.9996 3.9457; 1.9996 3.9471; 1.9997 3.9484; 1.9997 3.9496; 1.9997 3.9509; 1.9997 3.9521; 1.9997 3.9533; 1.9997 3.9544; 1.9998 3.9556; 1.9998 3.9567; 1.9998 3.9577; 1.9998 3.9588; 1.9998 3.9598; 1.9998 3.9608; 1.9998 3.9618; 1.9998 3.9627; 1.9998 3.9636; 1.9998 3.9645; 1.9999 3.9654; 1.9999 3.9662; 1.9999 3.9671; 1.9999 3.9679; 1.9999 3.9687; 1.9999 3.9695; 1.9999 3.9702; 1.9999 3.9709; 1.9999 3.9717; 1.9999 3.9724; 1.9999 3.9730; 1.9999 3.9737; 1.9999 3.9744; 1.9999 3.9750; 1.9999 3.9756; 1.9999 3.9762; 1.9999 3.9768; 1.9999 3.9774; 1.9999 3.9779; 1.9999 3.9785; 1.9999 3.9790; 1.9999 3.9795; 2.0000 3.9800; 2.0000 3.9805; 2.0000 3.9810; 2.0000 3.9815; 2.0000 3.9819; 2.0000 3.9824; 2.0000 3.9828; 2.0000 3.9832; 2.0000 3.9837; 2.0000 3.9841; 2.0000 3.9845; 2.0000 3.9848; 2.0000 3.9852; 2.0000 3.9856; 2.0000 3.9859; 2.0000 3.9863; 2.0000 3.9866; 2.0000 3.9869; 2.0000 3.9873; 2.0000 3.9876; 2.0000 3.9879; 2.0000 3.9882; 2.0000 3.9885; 2.0000 3.9888; 2.0000 3.9890; 2.0000 3.9893; 2.0000 3.9896; 2.0000 3.9898; 2.0000 3.9901; 2.0000 3.9903; 2.0000 3.9906; 2.0000 3.9908; 2.0000 3.9910; 2.0000 3.9913; 2.0000 3.9915; 2.0000 3.9917; 2.0000 3.9919; 2.0000 3.9921; 2.0000 3.9923; 2.0000 3.9925; 2.0000 3.9927; 2.0000 3.9928; 2.0000 3.9930; 2.0000 3.9932; 2.0000 3.9934; 2.0000 3.9935; 2.0000 3.9937; 2.0000 3.9938; 2.0000 3.9940; 2.0000 3.9941; 2.0000 3.9943; 2.0000 3.9944; 2.0000 3.9946; 2.0000 3.9947; 2.0000 3.9948; 2.0000 3.9950; 2.0000 3.9951; 2.0000 3.9952; 2.0000 3.9953; 2.0000 3.9954; 2.0000 3.9955; 2.0000 3.9957; 2.0000 3.9958; 2.0000 3.9959; 2.0000 3.9960; 2.0000 3.9961; 2.0000 3.9962; 2.0000 3.9963; 2.0000 3.9964; 2.0000 3.9964; 2.0000 3.9965; 2.0000 3.9966; 2.0000 3.9967; 2.0000 3.9968; 2.0000 3.9969; 2.0000 3.9969; 2.0000 3.9970; 2.0000 3.9971; 2.0000 3.9972; 2.0000 3.9972; 2.0000 3.9973; 2.0000 3.9974; 2.0000 3.9974; 2.0000 3.9975; 2.0000 3.9976; 2.0000 3.9976; 2.0000 3.9977; 2.0000 3.9977; 2.0000 3.9978; 2.0000 3.9978; 2.0000 3.9979; 2.0000 3.9979; 2.0000 3.9980; 2.0000 3.9980; 2.0000 3.9981; 2.0000 3.9981; 2.0000 3.9982; 2.0000 3.9982; 2.0000 3.9983; 2.0000 3.9983; 2.0000 3.9984; 2.0000 3.9984; 2.0000 3.9984; 2.0000 3.9985; 2.0000 3.9985; 2.0000 3.9986; 2.0000 3.9986; 2.0000 3.9986; 2.0000 3.9987; 2.0000 3.9987; 2.0000 3.9987; 2.0000 3.9988; 2.0000 3.9988; 2.0000 3.9988; 2.0000 3.9988; 2.0000 3.9989; 2.0000 3.9989; 2.0000 3.9989; 2.0000 3.9990; 2.0000 3.9990; 2.0000 3.9990; 2.0000 3.9990; 2.0000 3.9991; 2.0000 3.9991; 2.0000 3.9991; 2.0000 3.9991; 2.0000 3.9991; 2.0000 3.9992; 2.0000 3.9992; 2.0000 3.9992; 2.0000 3.9992; 2.0000 3.9992; 2.0000 3.9993; 2.0000 3.9993; 2.0000 3.9993; 2.0000 3.9993; 2.0000 3.9993; 2.0000 3.9994; 2.0000 3.9994; 2.0000 3.9994; 2.0000 3.9994; 2.0000 3.9994; 2.0000 3.9994; 2.0000 3.9994; 2.0000 3.9995; 2.0000 3.9995; 2.0000 3.9995; 2.0000 3.9995; 2.0000 3.9995; 2.0000 3.9995; 2.0000 3.9995; 2.0000 3.9995; 2.0000 3.9996; 2.0000 3.9996; 2.0000 3.9996; 2.0000 3.9996; 2.0000 3.9996; 2.0000 3.9996; 2.0000 3.9996; 2.0000 3.9996; 2.0000 3.9996; 2.0000 3.9996; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9997; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9998; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 3.9999; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000; 2.0000 4.0000];

% Regulator parameters
D = 200;  % Dynamic horizon
N = 100;  % Prediction horizon
Nu = 8;  % Moving horizon
mi = ones(1, ny);  % Output importance
lambda = ones(1, nu);  % Control weight
uMin = -2;
uMax = -uMin;
duMin = -0.5;
duMax = -duMin;
algType = 'fast';

% Regulator
reg = DMC(D, N, Nu, ny, nu, stepResponse, 'mi', mi, 'lambda', lambda,...
    'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
    'algType', algType);

% Trajectory
[YYzad, kk, ypp, upp, ~] = getY2Trajectory(osf);

% Variable initialisation
YY = ones(kk, ny) * ypp;
UU = ones(kk, nu) * upp;
YY_k_1 = ones(1, ny) * ypp;

% Control loop
for k=1:kk
    reg = reg.calculateControl(YY_k_1, YYzad(k, :));
    UU(k, :) = reg.getControl();
    YY(k, :) = simulateObjectDMC(ny, nu, InputDelay, YY, ypp, UU, upp, k);
    YY_k_1 = YY(k, :);
end

% Plotting
plotRun(YY, YYzad, UU, 0.01, ny, nu, 'DMC', algType);

% Control error
err = Utilities.calculateError(YY, YYzad)
